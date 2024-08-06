Return-Path: <linux-fsdevel+bounces-25126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F099495AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696C6B22582
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85F136330;
	Tue,  6 Aug 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF4urpEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763980043
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960158; cv=none; b=gsMl/lLI9pP1Ib/Tc1dORhik7j0tJk+hNqouO4Jjt00+uPonRHzpINHpJotvcdl+GHUaTYHUSz0Cr1d1mMolBrM+Uuso44B+VxSXya3ZIw7hDhzZXs3X7qGYgKfJ1T4KNq2tXLU4E3S8W/+6CP3SfzjmmzNu6RxEK0i2h9IX4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960158; c=relaxed/simple;
	bh=OQaVs3g2ZQwgR9Eb5FPuOoMg0In4wTMM6R4GmWMEhEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PIXRjQxqHPlrBQu2yggCQDa5QTQJnNL3Ffv7MJejDu3lL+b/DvwIv9ffGJPYrSd4zAqvHL5nKgIu3LhS2Av41IJBasAycYAMbwjyJohb+eLoMSxYZZkmD+0nbd8dcJV/hi00viZcQKeb4DsiYauGny/ETTP2MhUGeIJIzv8ZYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF4urpEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4DFC32786;
	Tue,  6 Aug 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960157;
	bh=OQaVs3g2ZQwgR9Eb5FPuOoMg0In4wTMM6R4GmWMEhEE=;
	h=From:Subject:Date:To:Cc:From;
	b=LF4urpEPTKTieez82+He9OFtTtmg8znBmRWTWO3H6Bzmv1qmMgEyunpgspjVMOsXM
	 BCSkwqx+kIXzTShUMQ0iPvMqXDmjayY8G8meu7Jh41+Age9eVhVNNWxdsmec6WZqzj
	 QpqOU+/4o0GLl2jms3Wk4UNN2XRSuAW64FtHMoYho9VEIIXINdAbJZDuDnfeZWJNQI
	 UELlXdo9WjC8pK43Z/tbpto0XCAEEMRAEFxcQb32/v9ZyeYAr12BPlDrbU4Y1vyLfq
	 hiQQKa9gM728br7W6EprjXrjAcm8iJeelOZC2gykM3qzXAmOYe0cETSYp9avrvznTT
	 dqKKCG+/+DR1Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/6] proc: restrict overmounting of ephemeral entities
Date: Tue, 06 Aug 2024 18:02:26 +0200
Message-Id: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJJsmYC/x2MywrCMBAAf6Xs2S1NKiZ6LfgBXsVDHlsbxKTsS
 hVK/93ocQZmVhDiRAKnZgWmJUkquYLaNRAml++EKVYG3el9Z3qF78IPnLmEUZCsjtHaozemh1r
 MTGP6/G9XuJwHuFXpnRB6djlMv9HTyYu4XQ6tUshBwbZ9AQQsilqFAAAA
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4973; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OQaVs3g2ZQwgR9Eb5FPuOoMg0In4wTMM6R4GmWMEhEE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pQuSnDcxJP+6maNm9s87hj29atjTW4bFPeaLro74
 fECv85FHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOprWH4X85juyDzUPif6qnX
 P3dtCNRvXcDwluNf6/0v+6cXGiaJLmX473PyxJz1avtvF3Jo6Hz28qu/GjwnZ+6knDfB1e5eqRa
 czAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

(Preface because I've been panick-approached by people at conference
 when we discussed this before: overmounting any global procfs files
 such as /proc/status remains unaffected and is an existing and
 supported use-case.)

It is currently possible to mount on top of various ephemeral entities
in procfs. This specifically includes magic links. To recap, magic links
are links of the form /proc/<pid>/fd/<nr>. They serve as references to
a target file and during path lookup they cause a jump to the target
path. Such magic links disappear if the corresponding file descriptor is
closed.

Currently it is possible to overmount such magic links:

int fd = open("/mnt/foo", O_RDONLY);
sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
int fd2 = openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
mount("/mnt/bar", path, "", MS_BIND, 0);

Arguably, this is nonsensical and is mostly interesting for an attacker
that wants to somehow trick a process into e.g., reopening something
that they didn't intend to reopen or to hide a malicious file
descriptor.

But also it risks leaking mounts for long-running processes. When
overmounting a magic link like above, the mount will not be detached
when the file descriptor is closed. Only the target mountpoint will
disappear. Which has the consequence of making it impossible to unmount
that mount afterwards. So the mount will stick around until the process
exits and the /proc/<pid>/ directory is cleaned up during
proc_flush_pid() when the dentries are pruned and invalidated.

That in turn means it's possible for a program to accidentally leak
mounts and it's also possible to make a task leak mounts without it's
knowledge if the attacker just keeps overmounting things under
/proc/<pid>/fd/<nr>.

I think it's wrong to try and fix this by us starting to play games with
close() or somewhere else to undo these mounts when the file descriptor
is closed. The fact that we allow overmounting of such magic links is
simply a bug and one that we need to fix.

Similar things can be said about entries under fdinfo/ and map_files/ so
those are restricted as well.

I have a further more aggressive patch that gets out the big hammer and
makes everything under /proc/<pid>/*, as well as immediate symlinks such
as /proc/self, /proc/thread-self, /proc/mounts, /proc/net that point
into /proc/<pid>/ not overmountable. Imho, all of this should be blocked
if we can get away with it. It's only useful to hide exploits such as in [1].

And again, overmounting of any global procfs files remains unaffected
and is an existing and supported use-case.

Link: https://righteousit.com/2024/07/24/hiding-linux-processes-with-bind-mounts [1]

// Note that repro uses the traditional way of just mounting over
// /proc/<pid>/fd/<nr>. This could also all be achieved just based on
// file descriptors using move_mount(). So /proc/<pid>/fd/<nr> isn't the
// only entry vector here. It's also possible to e.g., mount directly
// onto /proc/<pid>/map_files/* without going over /proc/<pid>/fd/<nr>.
int main(int argc, char *argv[])
{
        char path[PATH_MAX];

        creat("/mnt/foo", 0777);
        creat("/mnt/bar", 0777);

        /*
         * For illustration use a bunch of file descriptors in the upper
         * range that are unused.
         */
        for (int i = 10000; i >= 256; i--) {
                printf("I'm: /proc/%d/\n", getpid());

                int fd2 = open("/mnt/foo", O_RDONLY);
                if (fd2 < 0) {
                        printf("%m - Failed to open\n");
                        _exit(1);
                }

                int newfd = dup2(fd2, i);
                if (newfd < 0) {
                        printf("%m - Failed to dup\n");
                        _exit(1);
                }
                close(fd2);

                sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
                int fd = openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
                if (fd < 0) {
                        printf("%m - Failed to open\n");
                        _exit(3);
                }

                sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
                printf("Mounting on top of %s\n", path);
                if (mount("/mnt/bar", path, "", MS_BIND, 0)) {
                        printf("%m - Failed to mount\n");
                        _exit(4);
                }

                close(newfd);
                close(fd2);
        }

        /*
         * Give some time to look at things. The mounts now linger until
         * the process exits.
         */
        sleep(10000);
        _exit(0);
}

Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240731-work-procfs-e82dd889b773


