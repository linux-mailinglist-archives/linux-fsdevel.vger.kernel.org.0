Return-Path: <linux-fsdevel+bounces-77034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LlUMHkLjmmS+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:18:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697012FD7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A843D303F7D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27B201113;
	Thu, 12 Feb 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUEZ0jbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB21C68F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916676; cv=none; b=TDivqvahhmcjNn31QL9EetvtXLGuX0XtfjtDk84bLkZG0VOVTyHa3ALA6wr++a/BrghiQJ1Q+hRuqeA89fvJm1bKmD2TVkUjid9HjK/xKc7b0O9AulJpz6zWE4lWYUZNIMEpR6hypVp3vVaHyuL8Ja3cbIY+XBHa0eojH3PSSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916676; c=relaxed/simple;
	bh=afg2NR2w1P/RT1c6C3CFDBOb7QacoEa/taowW/ZYNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZNpjZ0eT1VTUm15l7CZRgdWRa18eSNzMTnntYcYaiz1uZaV8a6MbwVn3IGlMMCQPWpNgqfn3Ikj0jipUvAnvlV3dyU1ciie0AgM7jTr79jysHg/rauFsKf+5d26z1chlBsbHN/+0yHj78Hm/OCm1+geATdmtsx6IHrtg5eA6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUEZ0jbI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43770c94dfaso106508f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770916674; x=1771521474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZFiyy84JqXJnR6+ogt/LyFANHx9ok1PPIcxri4URUI=;
        b=kUEZ0jbIsLLCZUAe7xUE1J97A4aFxWCm0X3Njz+qfqzf9WaeBqAyRC9BgL6DOz2SYR
         k9PhRcsNpnbsKjsjRAENcD81EXJxtNKrbMCHJr00U0dWYiriGiAsgS3vSxgqW/w0yC58
         d3yFC2M8Vvuxj8b/F4lWpyknffF+SWXaaX//pw1nkmOMQyetTlEjTiXUkzzGIUORsq4f
         NRk2jDrLHD3u2EOkYVxZB4Psrti5IfB+rsR0mh4ZIwsi+/iBtxJbs6euKIzPGWNh/ZDo
         kf22gVruwB0pdC6/6Pt82GDvM9Mscpm5FH3J0djQRsIM2CKfLQRqOwtFM/3Z1JN3XnFk
         6mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770916674; x=1771521474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZFiyy84JqXJnR6+ogt/LyFANHx9ok1PPIcxri4URUI=;
        b=RYoC8J9auO+Ibr2iTveG6FbJwlNm3BBqGKGQ1uRlDet5LV2v2kChyufqWdMNtBPLkr
         IGguFZYiBdSE2T/xaGGTiOpA4TA574P0Vy2BIOL9mXllr1Vu8QibFT7v0Bn7yAkAZ8pC
         ArbRrbDVt7UT4lJxuCo79Ci5u7hOVBQZNI4OmU1N4WfWMlC5PzEJoSvF/Csu7Ckqhc8h
         IGtmHIZL2YNMq55g+v3DXH3cGYxrW5vrQchE7wJ0eoeCcD3jNXP0TvN+MFWq7BmifVaq
         nAs3qzE8GA0QuHrrtjxdaNTyw7Fl0se08UHwCo/sMIjCoKRCHmdESUz4D8pw7MRR1byl
         aiNw==
X-Forwarded-Encrypted: i=1; AJvYcCXSCNNIoz3fowUP/yVj7NXSHBXRNPEyf3qV78E3NiAPQovzNLDGwRp8CF3/hriJYtpk03aH9+ZBx5IGyscl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSdaG1vuaz94BUiyd9QWPdq8tIqGu7Dj+oZMizOguXR6jmHoN
	PW1pi/HbKAVdsbug6tABySeg9+LhyK2v/N7lTC2xRmf7Ouv3365Bt950
X-Gm-Gg: AZuq6aJ0kHH70jsNqgKz6oSx5rGCQVZLRhVJFipj7PEe9UbJTBsqH7JiVfsphgARJBs
	Bu39a0whPkv6IUGBXyiiKXr19iwqK5+KC8Az9SbYioOGiNsTzDFF4/kRgJMqNbjoEDJTYuNwPnm
	BAVvjNADUD7E0YehG29gmF3XFqm9JwgXQYrc8WUkLrcKOVaJuxBMHa0wZuIpt96ZiD7cz/SeZgH
	Frh6rRhdaXWgvOdAOR7wydaxKYIWP58bGkc8IQ0/s7n5A6o/1lUTvhOUMsZI5PwAHywPC1/7kQ8
	zjExJcwqMm1u8jZzReCvQeI+VbHh6BgVawl3e0K4s2T0XoggB9dtULzPmJv54mDQKElq2VdRwPI
	AqV+JXGjVIxbNtyxIaENqUzTa+aQfz8+Xd5+M3vIfXuC9Oh0hK9GrR1OFNr1NYiO7cW/dpkJE5w
	nJ8m/DbOpFOZXmPLs7kkc=
X-Received: by 2002:a05:6000:1acb:b0:430:fa58:a03d with SMTP id ffacd0b85a97d-4378f171792mr5892319f8f.63.1770916673453;
        Thu, 12 Feb 2026 09:17:53 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43783d34657sm15602574f8f.6.2026.02.12.09.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:17:52 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: christian@brauner.io,
	hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	werner@almesberger.net,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] pivot_root(2) races
Date: Thu, 12 Feb 2026 20:17:17 +0300
Message-ID: <20260212171717.2927887-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77034-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 2697012FD7A
X-Rspamd-Action: no action

Linus Torvalds <torvalds@linux-foundation.org>:
> IOW, imagine that I'm system root, and I've naively done a "cd
> /proc/<pid>/cwd" to look at the state of some sucker, and now...
> 
> Am I mis-reading things entirely, or can a random process in that
> container (that has mount permissions in that thing) basically do
> pivot_root(), and in the process change the CWD of that root process
> that just happens to be looking at that container state?

Yes, exactly. I just tested it. In the end of this letter you will find
the code.

I tested on 6.12.48, but I'm nearly sure this applies to later versions, too.

In my opinion this is a bug. We should make pivot_root change cwd and root
for processes in the same mount and user namespace only, not all processes
on the system. (And possibly also require "can ptrace" etc.)

This bug is yet another way for a container to mess with container runtime
(so I CC Sarai).

Here is how my code works. I assume we start as UID 0 (in any user namespace).
Then I create child and in that child I change UID to 1, then in child I do
unshare (CLONE_NEWUSER | CLONE_NEWNS).

Then in parent (which still runs as root) I do cd to /proc/$CHILD/cwd.

Then in child I do pivot_root.

And then parent sees that its cwd changed.

The most important part is here:

    ASSERT (access ("tmp/pivot_root", F_OK) == 0);
    ASSERT (sleep (2) == 0); // Wait for "pivot_root" in child
    ASSERT (access ("tmp/pivot_root", F_OK) != 0);

We wait for pivot_root to happen, and then (using "access") we see that
our cwd in fact changed.

The program should print "OK" and nothing else. If it printed "OK", this
will mean that we indeed can mess with outer processes.

So we see that pivot_root can change cwd/root across users, user namespaces
and mount namespaces.

-- 
Askar Safin

// Run this program as root (uid 0) in any user namespace
// CLONE_NEWUSER should be enabled on the system (it is disabled in some distros)

// You have two options to run this program. First as real root:
// $ sudo ./prog
// Second: as root inside a user namespace:
// $ unshare --map-users auto --map-groups auto -r ./prog
// (make sure you have "newuidmap" installed)

// Written by me without LLMs...
// Public domain

// The program should print "OK" and nothing else. This will mean that processes
// inside container indeed can change cwd of outer processes using pivot_root

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>

#define ASSERT(cond)       do { if (!(cond)) { fprintf (stderr, "%d: %s: failed\n", __LINE__, #cond); exit (EXIT_FAILURE); } } while (0)
#define ASSERT_ERRNO(cond) do { if (!(cond)) { fprintf (stderr, "%d: %s: %m\n",     __LINE__, #cond); exit (EXIT_FAILURE); } } while (0)

int
main (void)
{
    ASSERT_ERRNO (chdir ("/") == 0);

    // From previous runs
    if (rmdir ("/tmp/pivot_root/new-root") == -1 && errno != ENOENT)
        {
            fprintf (stderr, "Cannot remove tmp dirs from previous run");
            exit (EXIT_FAILURE);
        }
    if (rmdir ("/tmp/pivot_root") == -1 && errno != ENOENT)
        {
            fprintf (stderr, "Cannot remove tmp dirs from previous run");
            exit (EXIT_FAILURE);
        }

    ASSERT (getuid () == 0);
    ASSERT (getgid () == 0);

    pid_t child = fork ();

    ASSERT_ERRNO (child != -1);

    if (child == 0)
        {
            ASSERT_ERRNO (setgid (1) == 0);
            ASSERT_ERRNO (setuid (1) == 0);

            ASSERT_ERRNO (mkdir ("/tmp/pivot_root", 0700) == 0);

            ASSERT_ERRNO (unshare (CLONE_NEWUSER | CLONE_NEWNS) == 0);

            ASSERT (sleep (2) == 0); // Wait for parent to setup uid_map, etc

            ASSERT_ERRNO (mkdir ("/tmp/pivot_root/new-root", 0700) == 0);
            ASSERT_ERRNO (mount ("tmpfs", "/tmp/pivot_root/new-root", "tmpfs", 0, NULL) == 0);
            ASSERT_ERRNO (mkdir ("/tmp/pivot_root/new-root/put-old", 0700) == 0);
            ASSERT_ERRNO (syscall (SYS_pivot_root, "/tmp/pivot_root/new-root", "/tmp/pivot_root/new-root/put-old") == 0);
            exit (0);
        }

    ASSERT (sleep (1) == 0); // Wait for child to do unshare

    // See "man 7 user_namespaces" about these /proc/self/uid_map, etc
    {
        char ss[1000];
        ASSERT (snprintf (ss, sizeof ss, "/proc/%lld/uid_map", (long long)child) > 0);
        int fd = open (ss, O_WRONLY);
        ASSERT_ERRNO (fd != -1);
        char s[] = "0 1 1";
        ASSERT (write (fd, s, strlen (s)) == (ssize_t)strlen (s));
        ASSERT_ERRNO (close (fd) == 0);
    }
    {
        char ss[1000];
        ASSERT (snprintf (ss, sizeof ss, "/proc/%lld/setgroups", (long long)child) > 0);
        int fd = open (ss, O_WRONLY);
        ASSERT_ERRNO (fd != -1);
        ASSERT (write (fd, "deny", strlen ("deny")) == (ssize_t)strlen ("deny"));
        ASSERT_ERRNO (close (fd) == 0);
    }
    {
        char ss[1000];
        ASSERT (snprintf (ss, sizeof ss, "/proc/%lld/gid_map", (long long)child) > 0);
        int fd = open (ss, O_WRONLY);
        ASSERT_ERRNO (fd != -1);
        char s[] = "0 1 1";
        ASSERT (write (fd, s, strlen (s)) == (ssize_t)strlen (s));
        ASSERT_ERRNO (close (fd) == 0);
    }
    {
        char s[1000];
        ASSERT (snprintf (s, sizeof s, "/proc/%lld/cwd", (long long)child) > 0);
        ASSERT_ERRNO (chdir (s) == 0);
    }

    // These 3 lines are the most important part
    ASSERT (access ("tmp/pivot_root", F_OK) == 0);
    ASSERT (sleep (2) == 0); // Wait for "pivot_root" in child
    ASSERT (access ("tmp/pivot_root", F_OK) != 0);

    {
        int status;
        ASSERT_ERRNO (waitpid (child, &status, 0) != -1);
        ASSERT (WIFEXITED (status));
        ASSERT (WEXITSTATUS (status) == 0);
    }

    printf ("OK\n");

    return 0;
}

