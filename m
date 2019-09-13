Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB4B1E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfIMNGm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 09:06:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbfIMNGl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:06:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E074330615C1;
        Fri, 13 Sep 2019 13:06:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB47413B;
        Fri, 13 Sep 2019 13:06:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <25289.1568379639@warthog.procyon.org.uk>
References: <25289.1568379639@warthog.procyon.org.uk>
To:     torvalds@linuxfoundation.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: My just-shovel-data-through-for-X-amount-of-time test
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25717.1568379999.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 Sep 2019 14:06:39 +0100
Message-ID: <25718.1568379999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 13:06:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/*
 * Benchmark a pipe by seeing how many 511-byte writes can be stuffed through
 * it in a certain amount of time.  Compile with -lm.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <math.h>
#include <sys/wait.h>
#include <sys/mman.h>

static char buf1[4096] __attribute__((aligned(4096)));
static char buf2[4096] __attribute__((aligned(4096)));
static unsigned long long *results;

static volatile int stop;
void sigalrm(int sig)
{
	stop = 1;
}

static __attribute__((noreturn))
void producer(int fd, int i)
{
	unsigned long long l = 0;
	ssize_t n;

	signal(SIGALRM, sigalrm);
	alarm(1);

	while (!stop) {
		n = write(fd, buf1, 511);
		if (n == -1) {
			perror("read");
			exit(1);
		}

		l += n;
	}

	results[i] = l;
	exit(0);
}

static __attribute__((noreturn))
void consumer(int fd)
{
	unsigned long long l = 0;
	ssize_t n;

	for (;;) {
		n = read(fd, buf2, 4096);
		if (n == 0)
			break;
		if (n == -1) {
			perror("read");
			exit(1);
		}

		l += n;
	}

	exit(0);
}

unsigned long long stddev(const unsigned long long *vals, int nvals)
{
	double sum = 0.0, mean, sd = 0.0;
	int i;

	for (i = 0; i < nvals; i++)
		sum += vals[i];

	mean = sum / nvals;
	for (i = 0; i < nvals; i++)
		sd += pow(vals[i] - mean, 2);
	return sqrt(sd / 10);
}

int main()
{
	unsigned long long t = 0;
	int ex = 0, i;

	results = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON, -1, 0);
	if (results == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}

	for (i = 0; i < 16 && ex == 0; i++) {
		pid_t prod, con;
		int pfd[2], wt;

		if (pipe2(pfd, 0) < 0) {
			perror("pipe");
			exit(1);
		}

		con = fork();
		switch (con) {
		case -1:
			perror("fork/c");
			exit(1);
		case 0:
			close(pfd[1]);
			consumer(pfd[0]);
		default:
			break;
		}

		prod = fork();
		switch (prod) {
		case -1:
			perror("fork/p");
			exit(1);
		case 0:
			close(pfd[0]);
			producer(pfd[1], i);
		default:
			break;
		}

		close(pfd[0]);
		close(pfd[1]);

		for (;;) {
			errno = 0;
			wait(&wt);
			if (errno == ECHILD)
				break;
			if (!WIFEXITED(wt) || WEXITSTATUS(wt) != 0)
				ex = 1;
		}

		printf("WR[%02u]: %12llu\n", i, results[i]);
		t += results[i];
	}

	printf("total : %12llu\n", t);
	printf("avg   : %12llu\n", t / i);
	printf("stddev: %12llu\n", stddev(results, i));
	exit(ex);
}
