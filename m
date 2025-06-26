Return-Path: <linux-fsdevel+bounces-53077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA14AE9BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D0C3BD186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F22367BB;
	Thu, 26 Jun 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5oMcUyO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jgNELZw9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5oMcUyO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jgNELZw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F41FBCB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934938; cv=none; b=UgwaqIaBVP61CXXIII1Alw8g/zpkV/aux774j2sWXuPmmj0ouqqXMGB6FZNQmJAquSgZGeCT4wbMkMwXlP3Lua0MoIQ9vnQ3untdeJhsp7L5Rd75xrXyuCwcn/FFcI9c2dilwg6OHAgys4aYcOBUjtmuqlRU2WAWpFEIx95nrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934938; c=relaxed/simple;
	bh=MKk3wM0Nq/3yOpUUqqRUClqTc/gMYL8L8F4nKzsIapQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef5pSI1dB1NO5tDIB3MD1kXNFFucV4MzNHUo3Bogi0T4kDcs5s17X7wpImZrBIjBH2ExRY4VhUf9y4Lr/fl8IFhug0f014TjekPXhFSRgKfLzWritAe/LHem6ToMcpxDniK6Kl2yIkpnEpd6MHbucM0APq3472izYtjXZ0gStUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5oMcUyO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jgNELZw9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5oMcUyO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jgNELZw9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B3AB21174;
	Thu, 26 Jun 2025 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750934934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFi20Uz5dGzIPWTgMlYhu55C9B4FZ5vIDyRPWsebQrE=;
	b=o5oMcUyOLLXSmOV2LI5z3CmPulMI9UMwDx+5wvzwVdn0WGmOISMimRLKD2DCn8ERiOnXa+
	VDQjLycPizw5vjjyZAQZP+ZqT0EBALbm7ST9IA7fR+QQ6Lfm/OqcXNTN6H0uWhVgkDRjj0
	88UjInFi8eZmL3Ke0DxM5az09zgm62g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750934934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFi20Uz5dGzIPWTgMlYhu55C9B4FZ5vIDyRPWsebQrE=;
	b=jgNELZw96rnJWUzBiybVgG5flBcbte5I+n93SbhagDRUdoWoHG/n5Sp30cMEKr8GGrb6rA
	nzSTaBrnynrTXzCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o5oMcUyO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jgNELZw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750934934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFi20Uz5dGzIPWTgMlYhu55C9B4FZ5vIDyRPWsebQrE=;
	b=o5oMcUyOLLXSmOV2LI5z3CmPulMI9UMwDx+5wvzwVdn0WGmOISMimRLKD2DCn8ERiOnXa+
	VDQjLycPizw5vjjyZAQZP+ZqT0EBALbm7ST9IA7fR+QQ6Lfm/OqcXNTN6H0uWhVgkDRjj0
	88UjInFi8eZmL3Ke0DxM5az09zgm62g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750934934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFi20Uz5dGzIPWTgMlYhu55C9B4FZ5vIDyRPWsebQrE=;
	b=jgNELZw96rnJWUzBiybVgG5flBcbte5I+n93SbhagDRUdoWoHG/n5Sp30cMEKr8GGrb6rA
	nzSTaBrnynrTXzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5109138A7;
	Thu, 26 Jun 2025 10:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FJz7M5UlXWivZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Jun 2025 10:48:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68EA6A09FD; Thu, 26 Jun 2025 12:48:37 +0200 (CEST)
Date: Thu, 26 Jun 2025 12:48:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: selftests for fanotify permission events
Message-ID: <bc4dvylqapkxdqme65cudioajevdcjvwesmgh5v6jmghosyoux@sazv6a4q3hml>
References: <20250623194455.2847844-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxgABrw4kTVPWBAbxDYnmbXmeMREv++ibtp4q1STdiWyag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgABrw4kTVPWBAbxDYnmbXmeMREv++ibtp4q1STdiWyag@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B3AB21174
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Score: -4.01
X-Spam-Level: 

Hi!

On Tue 24-06-25 07:58:59, Amir Goldstein wrote:
> On Mon, Jun 23, 2025 at 9:45 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > This adds selftests which exercise generating / responding to
> > permission events. They requre root privileges since
>                                          ^^^^ require
> > FAN_CLASS_PRE_CONTENT requires it.
> >
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > ---
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/filesystems/fanotify/.gitignore |   2 +
> >  .../selftests/filesystems/fanotify/Makefile   |   8 +
> >  .../filesystems/fanotify/fanotify_perm_test.c | 386 ++++++++++++++++++
> >  4 files changed, 397 insertions(+)
> >  create mode 100644 tools/testing/selftests/filesystems/fanotify/.gitignore
> >  create mode 100644 tools/testing/selftests/filesystems/fanotify/Makefile
> >  create mode 100644 tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
> >
> 
> Hi Ibrahim,
> 
> As a general comment, I do not mind having diverse testing
> methods, but just wanted to make sure that you know that we
> usually write fanotify tests to new features in LTP.
> 
> LTP vs. selftests have their pros and cons, but both bring value
> and add test coverage.
> selftests would not have been my first choice for this particular test,
> because it is so similar to tests already existing in LTP, e.g.:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify24.c

Yeah, frankly I'd prefer to keep tests in one place unless there's a good
reason not to. As you write in this case we already have very similar tests
in LTP so adding a coverage for the new functionality there seems like a
no-brainer...

> but I suppose that testing the full functionality of event listener fd handover
> might be easier to implement with the selftest infrastructure.
> Anyway, I will not require you to use one test suite or the other if you have
> a preference.

If there's some functionality that's hard to test from LTP, we can consider
implementing that in kselftests but I'd like to hear those reasons first...

								Honza

> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 339b31e6a6b5..9cae71edca9f 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -32,6 +32,7 @@ TARGETS += fchmodat2
> >  TARGETS += filesystems
> >  TARGETS += filesystems/binderfs
> >  TARGETS += filesystems/epoll
> > +TARGETS += filesystems/fanotify
> >  TARGETS += filesystems/fat
> >  TARGETS += filesystems/overlayfs
> >  TARGETS += filesystems/statmount
> > diff --git a/tools/testing/selftests/filesystems/fanotify/.gitignore b/tools/testing/selftests/filesystems/fanotify/.gitignore
> > new file mode 100644
> > index 000000000000..a9f51c9aca9f
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/fanotify/.gitignore
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +fanotify_perm_test
> > diff --git a/tools/testing/selftests/filesystems/fanotify/Makefile b/tools/testing/selftests/filesystems/fanotify/Makefile
> > new file mode 100644
> > index 000000000000..931bedd989b9
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/fanotify/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> > +LDLIBS += -lcap
> > +
> > +TEST_GEN_PROGS := fanotify_perm_test
> > +
> > +include ../../lib.mk
> > diff --git a/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
> > new file mode 100644
> > index 000000000000..87d718323b1a
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
> > @@ -0,0 +1,386 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#define _GNU_SOURCE
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <errno.h>
> > +#include <sys/syscall.h>
> > +#include <limits.h>
> > +
> > +#include "../../kselftest_harness.h"
> > +
> > +// Needed for linux/fanotify.h
> > +#ifndef __kernel_fsid_t
> > +typedef struct {
> > +       int val[2];
> > +} __kernel_fsid_t;
> > +#endif
> > +#include <sys/fanotify.h>
> > +
> > +static const char test_dir_templ[] = "/tmp/fanotify_perm_test.XXXXXX";
> > +
> > +FIXTURE(fanotify)
> > +{
> > +       char test_dir[sizeof(test_dir_templ)];
> > +       char test_dir2[sizeof(test_dir_templ)];
> > +       int fan_fd;
> > +       int fan_fd2;
> > +       char test_file_path[PATH_MAX];
> > +       char test_file_path2[PATH_MAX];
> > +       char test_exec_path[PATH_MAX];
> > +};
> > +
> > +FIXTURE_SETUP(fanotify)
> > +{
> > +       int ret;
> > +
> > +       /* Setup test directories and files */
> > +       strcpy(self->test_dir, test_dir_templ);
> > +       ASSERT_NE(mkdtemp(self->test_dir), NULL);
> > +       strcpy(self->test_dir2, test_dir_templ);
> > +       ASSERT_NE(mkdtemp(self->test_dir2), NULL);
> > +
> > +       snprintf(self->test_file_path, PATH_MAX, "%s/test_file",
> > +                self->test_dir);
> > +       snprintf(self->test_file_path2, PATH_MAX, "%s/test_file2",
> > +                self->test_dir2);
> > +       snprintf(self->test_exec_path, PATH_MAX, "%s/test_exec",
> > +                self->test_dir);
> > +
> > +       ret = open(self->test_file_path, O_CREAT | O_RDWR, 0644);
> > +       ASSERT_GE(ret, 0);
> > +       ASSERT_EQ(write(ret, "test data", 9), 9);
> > +       close(ret);
> > +
> > +       ret = open(self->test_file_path2, O_CREAT | O_RDWR, 0644);
> > +       ASSERT_GE(ret, 0);
> > +       ASSERT_EQ(write(ret, "test data2", 9), 9);
> > +       close(ret);
> > +
> > +       ret = open(self->test_exec_path, O_CREAT | O_RDWR, 0755);
> > +       ASSERT_GE(ret, 0);
> > +       ASSERT_EQ(write(ret, "#!/bin/bash\necho test\n", 22), 22);
> > +       close(ret);
> > +
> > +       self->fan_fd = fanotify_init(
> > +               FAN_CLASS_PRE_CONTENT | FAN_NONBLOCK | FAN_CLOEXEC, O_RDONLY);
> > +       ASSERT_GE(self->fan_fd, 0);
> > +
> > +       self->fan_fd2 = fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_NONBLOCK |
> > +                                             FAN_CLOEXEC | FAN_ENABLE_EVENT_ID,
> > +                                     O_RDONLY);
> > +       ASSERT_GE(self->fan_fd2, 0);
> > +
> > +       /* Mark the directories for permission events */
> > +       ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD,
> > +                           FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
> > +                                   FAN_EVENT_ON_CHILD,
> > +                           AT_FDCWD, self->test_dir);
> > +       ASSERT_EQ(ret, 0);
> > +
> > +       ret = fanotify_mark(self->fan_fd2, FAN_MARK_ADD,
> > +                           FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
> > +                                   FAN_EVENT_ON_CHILD,
> > +                           AT_FDCWD, self->test_dir2);
> > +       ASSERT_EQ(ret, 0);
> > +}
> > +
> > +FIXTURE_TEARDOWN(fanotify)
> > +{
> > +       /* Clean up test directory and files */
> > +       if (self->fan_fd > 0)
> > +               close(self->fan_fd);
> > +       if (self->fan_fd2 > 0)
> > +               close(self->fan_fd2);
> > +
> > +       EXPECT_EQ(unlink(self->test_file_path), 0);
> > +       EXPECT_EQ(unlink(self->test_file_path2), 0);
> > +       EXPECT_EQ(unlink(self->test_exec_path), 0);
> > +       EXPECT_EQ(rmdir(self->test_dir), 0);
> > +       EXPECT_EQ(rmdir(self->test_dir2), 0);
> > +}
> > +
> > +static struct fanotify_event_metadata *get_event(int fd)
> > +{
> > +       struct fanotify_event_metadata *metadata;
> > +       ssize_t len;
> > +       char buf[256];
> > +
> > +       len = read(fd, buf, sizeof(buf));
> > +       if (len <= 0)
> > +               return NULL;
> > +
> > +       metadata = (void *)buf;
> > +       if (!FAN_EVENT_OK(metadata, len))
> > +               return NULL;
> > +
> > +       return metadata;
> > +}
> > +
> > +static int respond_to_event(int fd, struct fanotify_event_metadata *metadata,
> > +                           uint32_t response, bool useEventId)
> > +{
> > +       struct fanotify_response resp;
> > +
> > +       if (useEventId) {
> > +               resp.event_id = metadata->event_id;
> > +       } else {
> > +               resp.fd = metadata->fd;
> > +       }
> > +       resp.response = response;
> > +
> > +       return write(fd, &resp, sizeof(resp));
> > +}
> > +
> > +static void verify_event(struct __test_metadata *const _metadata,
> > +                        struct fanotify_event_metadata *event,
> > +                        uint64_t expect_mask, int expect_pid)
> > +{
> > +       ASSERT_NE(event, NULL);
> > +       ASSERT_EQ(event->mask, expect_mask);
> > +
> > +       if (expect_pid > 0)
> > +               ASSERT_EQ(event->pid, expect_pid);
> > +}
> > +
> > +TEST_F(fanotify, open_perm_allow)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int fd, ret;
> > +       pid_t child;
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               /* Try to open the file - this should trigger FAN_OPEN_PERM */
> > +               fd = open(self->test_file_path, O_RDONLY);
> > +               if (fd < 0)
> > +                       exit(EXIT_FAILURE);
> > +               close(fd);
> > +               exit(EXIT_SUCCESS);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd);
> > +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> > +
> > +       /* Allow the open operation */
> > +       close(event->fd);
> > +       ret = respond_to_event(self->fan_fd, event, FAN_ALLOW,
> > +                              false /* useEventId */);
> > +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> > +}
> > +
> > +TEST_F(fanotify, open_perm_deny)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int ret;
> > +       pid_t child;
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               /* Try to open the file - this should trigger FAN_OPEN_PERM */
> > +               int fd = open(self->test_file_path, O_RDONLY);
> > +
> > +               /* If open succeeded, this is an error as we expect it to be denied */
> > +               if (fd >= 0) {
> > +                       close(fd);
> > +                       exit(EXIT_FAILURE);
> > +               }
> > +
> > +               /* Verify the expected error */
> > +               if (errno == EPERM)
> > +                       exit(EXIT_SUCCESS);
> > +
> > +               exit(EXIT_FAILURE);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd);
> > +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> > +
> > +       /* Deny the open operation */
> > +       close(event->fd);
> > +       ret = respond_to_event(self->fan_fd, event, FAN_DENY,
> > +                              false /* useEventId */);
> > +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> > +}
> > +
> > +TEST_F(fanotify, exec_perm_allow)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int ret;
> > +       pid_t child;
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               /* Try to execute the file - this should trigger FAN_OPEN_EXEC_PERM */
> > +               execl(self->test_exec_path, "test_exec", NULL);
> > +
> > +               /* If we get here, execl failed */
> > +               exit(EXIT_FAILURE);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd);
> > +       verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
> > +
> > +       /* Allow the exec operation + ignore subsequent events */
> > +       ASSERT_GE(fanotify_mark(self->fan_fd,
> > +                               FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > +                                       FAN_MARK_IGNORED_SURV_MODIFY,
> > +                               FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM, event->fd,
> > +                               NULL),
> > +                 0);
> > +       close(event->fd);
> > +       ret = respond_to_event(self->fan_fd, event, FAN_ALLOW,
> > +                              false /* useEventId */);
> > +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WIFEXITED(status), 1);
> > +}
> > +
> > +TEST_F(fanotify, exec_perm_deny)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int ret;
> > +       pid_t child;
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               /* Try to execute the file - this should trigger FAN_OPEN_EXEC_PERM */
> > +               execl(self->test_exec_path, "test_exec", NULL);
> > +
> > +               /* If execl failed with EPERM, that's what we expect */
> > +               if (errno == EPERM)
> > +                       exit(EXIT_SUCCESS);
> > +
> > +               exit(EXIT_FAILURE);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd);
> > +       verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
> > +
> > +       /* Deny the exec operation */
> > +       close(event->fd);
> > +       ret = respond_to_event(self->fan_fd, event, FAN_DENY,
> > +                              false /* useEventId */);
> > +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> > +}
> > +
> > +TEST_F(fanotify, default_response)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int ret;
> > +       pid_t child;
> > +       struct fanotify_response resp;
> > +
> > +       /* Set default response to deny */
> > +       resp.fd = FAN_NOFD;
> > +       resp.response = FAN_DENY | FAN_DEFAULT;
> > +       ret = write(self->fan_fd, &resp, sizeof(resp));
> > +       ASSERT_EQ(ret, sizeof(resp));
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               close(self->fan_fd);
> > +               /* Try to open the file - this should trigger FAN_OPEN_PERM */
> > +               int fd = open(self->test_file_path, O_RDONLY);
> > +
> > +               /* If open succeeded, this is an error as we expect it to be denied */
> > +               if (fd >= 0) {
> > +                       close(fd);
> > +                       exit(EXIT_FAILURE);
> > +               }
> > +
> > +               /* Verify the expected error */
> > +               if (errno == EPERM)
> > +                       exit(EXIT_SUCCESS);
> > +
> > +               exit(EXIT_FAILURE);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd);
> > +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> > +
> > +       /* Close fanotify group to return default response (DENY) */
> > +       close(self->fan_fd);
> > +       self->fan_fd = -1;
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> > +}
> > +
> > +TEST_F(fanotify, respond_via_event_id)
> > +{
> > +       struct fanotify_event_metadata *event;
> > +       int fd, ret;
> > +       pid_t child;
> > +
> > +       child = fork();
> > +       ASSERT_GE(child, 0);
> > +
> > +       if (child == 0) {
> > +               /* Try to open the file - this should trigger FAN_OPEN_PERM */
> > +               fd = open(self->test_file_path2, O_RDONLY);
> > +               if (fd < 0)
> > +                       exit(EXIT_FAILURE);
> > +               close(fd);
> > +               exit(EXIT_SUCCESS);
> > +       }
> > +
> > +       usleep(100000);
> > +       event = get_event(self->fan_fd2);
> > +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> > +       ASSERT_EQ(event->event_id, 1);
> > +
> > +       /* Allow the open operation */
> > +       close(event->fd);
> > +       ret = respond_to_event(self->fan_fd2, event, FAN_ALLOW,
> > +                              true /* useEventId */);
> > +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> > +
> > +       int status;
> > +
> > +       ASSERT_EQ(waitpid(child, &status, 0), child);
> > +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> > +}
> > +
> > +TEST_HARNESS_MAIN
> > --
> > 2.47.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

