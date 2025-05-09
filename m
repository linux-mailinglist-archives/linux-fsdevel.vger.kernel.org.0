Return-Path: <linux-fsdevel+bounces-48572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A21AB1144
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7414C5654
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093128ECE0;
	Fri,  9 May 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joxNj1Wu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD721D3EF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788060; cv=none; b=bMrC2KjhYgK1LBpSJUXEy7suP3NHaBKibgNjKH97GYs+2G4HwHr4B+bXi5NFXUfITGtu3VKasY64qclPtcnBvsZcqCgb1eKbVg46twWay9maTFocNHYM2vqM8996hrx6nizcLWKpZ3RYDall6KzKV/AJ2YO6CZ//MTx8+kn1Tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788060; c=relaxed/simple;
	bh=RckD0vsTlke5o4+s0DDmNTU+ZXFZ5Xmdlt/utsylfVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqFAtGzBoOrP3A0RoOGZuQPJCSXPSRf/HwmCw1nMofSaHB6xT40609wS/3D8NF7j6AvijQ84J0KuvsEBAAntbIYYmiDN1IKNnzMzc54OXoziJnu6Bt2oWbXlPhNCTOPvtsIyYO7F7TqI8fVxN+Ftl8xBPW43fqMD/JEvbGnmsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joxNj1Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACABC4CEE4;
	Fri,  9 May 2025 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788056;
	bh=RckD0vsTlke5o4+s0DDmNTU+ZXFZ5Xmdlt/utsylfVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joxNj1Wu4oWpYR+QiVMbvaEWUY0ln2D7wJIucR1RT7/pewzcQD9Kl804tCCh6h8dW
	 g6GgNaIs8OVzaYH6wjR7gTKA6anQLoRb4vrQ8cOEJoVaiW55oLDMEX1Lr44kQxS1et
	 Y9QjR9urm/hDzSmmPFwxU2bSzvmFR806WnGXDKVhROG9zrbb5ZARu9fb2Q1OrHM1oj
	 7BZ1XcFLq5mIxRfptzRgTFAQ7bPLfIOJs1CNz4dnLvspmT4vZ4fplWeK+HnOvcdMwT
	 O3Uk8hCYG4LFGY72cnwqa5rHa2f96bmIG9xKu6Fd16wZeBwRBPLUWUy8o2Fhita34Z
	 Z5SDgi/c67fAg==
Date: Fri, 9 May 2025 12:54:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
Message-ID: <20250509-sensibel-plakette-510aa1bfc9ee@brauner>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-6-amir73il@gmail.com>
 <75a3cb6f-a9cc-441f-a43e-2f02fbfc49bf@nvidia.com>
 <CAOQ4uxiPgh0Lrt-7YnBQLTBFe-6aSUpgYVraoE_N=k0DrP7BEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiPgh0Lrt-7YnBQLTBFe-6aSUpgYVraoE_N=k0DrP7BEA@mail.gmail.com>

On Thu, May 08, 2025 at 02:08:16PM +0200, Amir Goldstein wrote:
> On Thu, May 8, 2025 at 9:52 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 5/7/25 1:43 PM, Amir Goldstein wrote:
> > > Add helper to utils and use it in statmount userns tests.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >   .../filesystems/statmount/statmount_test_ns.c | 60 +----------------
> > >   tools/testing/selftests/filesystems/utils.c   | 65 +++++++++++++++++++
> > >   tools/testing/selftests/filesystems/utils.h   |  1 +
> > >   3 files changed, 68 insertions(+), 58 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > > index 375a52101d08..3c5bc2e33821 100644
> > > --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > > +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > > @@ -79,66 +79,10 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
> > >       return NSID_PASS;
> > >   }
> > >
> > > -static int write_file(const char *path, const char *val)
> > > -{
> > > -     int fd = open(path, O_WRONLY);
> > > -     size_t len = strlen(val);
> > > -     int ret;
> > > -
> > > -     if (fd == -1) {
> > > -             ksft_print_msg("opening %s for write: %s\n", path, strerror(errno));
> > > -             return NSID_ERROR;
> > > -     }
> > > -
> > > -     ret = write(fd, val, len);
> > > -     if (ret == -1) {
> > > -             ksft_print_msg("writing to %s: %s\n", path, strerror(errno));
> > > -             return NSID_ERROR;
> > > -     }
> > > -     if (ret != len) {
> > > -             ksft_print_msg("short write to %s\n", path);
> > > -             return NSID_ERROR;
> > > -     }
> > > -
> > > -     ret = close(fd);
> > > -     if (ret == -1) {
> > > -             ksft_print_msg("closing %s\n", path);
> > > -             return NSID_ERROR;
> > > -     }
> > > -
> > > -     return NSID_PASS;
> > > -}
> > > -
> > >   static int setup_namespace(void)
> > >   {
> > > -     int ret;
> > > -     char buf[32];
> > > -     uid_t uid = getuid();
> > > -     gid_t gid = getgid();
> > > -
> > > -     ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
> > > -     if (ret == -1)
> > > -             ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
> > > -                                strerror(errno));
> > > -
> > > -     sprintf(buf, "0 %d 1", uid);
> > > -     ret = write_file("/proc/self/uid_map", buf);
> > > -     if (ret != NSID_PASS)
> > > -             return ret;
> > > -     ret = write_file("/proc/self/setgroups", "deny");
> > > -     if (ret != NSID_PASS)
> > > -             return ret;
> > > -     sprintf(buf, "0 %d 1", gid);
> > > -     ret = write_file("/proc/self/gid_map", buf);
> > > -     if (ret != NSID_PASS)
> > > -             return ret;
> > > -
> > > -     ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> > > -     if (ret == -1) {
> > > -             ksft_print_msg("making mount tree private: %s\n",
> > > -                            strerror(errno));
> > > +     if (setup_userns() != 0)
> > >               return NSID_ERROR;
> > > -     }
> > >
> > >       return NSID_PASS;
> > >   }
> > > @@ -200,7 +144,7 @@ static void test_statmount_mnt_ns_id(void)
> > >               return;
> > >       }
> > >
> > > -     ret = setup_namespace();
> > > +     ret = setup_userns();
> > >       if (ret != NSID_PASS)
> > >               exit(ret);
> > >       ret = _test_statmount_mnt_ns_id();
> > > diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
> > > index 9b5419e6f28d..9dab197ddd9c 100644
> > > --- a/tools/testing/selftests/filesystems/utils.c
> > > +++ b/tools/testing/selftests/filesystems/utils.c
> > > @@ -18,6 +18,7 @@
> > >   #include <sys/types.h>
> > >   #include <sys/wait.h>
> > >   #include <sys/xattr.h>
> > > +#include <sys/mount.h>
> > >
> > >   #include "utils.h"
> > >
> > > @@ -447,6 +448,70 @@ static int create_userns_hierarchy(struct userns_hierarchy *h)
> > >       return fret;
> > >   }
> > >
> > > +static int write_file(const char *path, const char *val)
> > > +{
> > > +     int fd = open(path, O_WRONLY);
> > > +     size_t len = strlen(val);
> > > +     int ret;
> > > +
> > > +     if (fd == -1) {
> > > +             syserror("opening %s for write: %s\n", path, strerror(errno));
> >
> > While I have no opinion about ksft_print_msg() vs. syserror(), I do
> > think it's worth a mention in the commit log: there is some reason
> > that you changed to syserror() throughout. Could you write down
> > what that was?
> 
> Very good question.
> 
> I admit I did not put much thought into this. I was blindly following
> Christian's lead in utils.c.
> I will revert those syserror back to ksft_print_msg().

I think I copied parts of that over from the work I did for xfstests
testing.

