Return-Path: <linux-fsdevel+bounces-76316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKUmBvxCg2nqkgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 14:00:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B6E61D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0E1300914B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEE407577;
	Wed,  4 Feb 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+QP+jzK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jZnWLqXf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+QP+jzK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jZnWLqXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712873F23AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209791; cv=none; b=j7/+PcPcXSV4h3BV1qaPpkwqpCq227Ud0yM3eelatRhIpf1AGQuyyTwDPDcU+nCSQ6d7z68gVL8b7Z5q27jFrszqo4bh/WdoRPCofzHl3g6jdOBtJIwkNfPmb5z6j63txzZWatYKQvlqCtp+4bAmlwsntZQ3s8s4YUcd3s2/I00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209791; c=relaxed/simple;
	bh=pr+QHI3XS89hX/EEdX444PxJm+KJZrxw+2E7xjrYKVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG4feZHek71SXERra53vhatv19kwv9HmaN8PmCHV9zFgV2BGQZ4Bx0PrN32fgqhkfKzjZnwPPRHxVZxXGBmy4QpVTva1hwFxDRtcnaCTtserAsQJdups2fQJSBY5554GfK9nWnQgnLrL4UPiJDia4RvVjKZZzR8T6poWcoReY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+QP+jzK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jZnWLqXf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+QP+jzK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jZnWLqXf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B43195BD1E;
	Wed,  4 Feb 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770209788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pFsO8VEkqNeQuzb+W7X/xq1SeWJK3QNdFbLN+DmM9U=;
	b=j+QP+jzKmHstzTjPkmCddMPXr5C9b6BvHXyjHpJeWexC7XktQsfdUwOsi/xQcoy4wc7IJZ
	cJlHQ8tRnR6/ztMEMcQMenVYHze0qN1V3O9Do273b+StZJWM8mP94YGezpPI8i5IZC4Fsk
	0HdSSX5+6Y9RcvNGlJb93gFIjEaRAWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770209788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pFsO8VEkqNeQuzb+W7X/xq1SeWJK3QNdFbLN+DmM9U=;
	b=jZnWLqXfJ/UIsuj8rRtYQJjsn9GEFY477zNDYcCBDmBBk6oh/JYiKj8nKYAlGk4yYCYnBy
	qfNsI1TqVOrnI9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j+QP+jzK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jZnWLqXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770209788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pFsO8VEkqNeQuzb+W7X/xq1SeWJK3QNdFbLN+DmM9U=;
	b=j+QP+jzKmHstzTjPkmCddMPXr5C9b6BvHXyjHpJeWexC7XktQsfdUwOsi/xQcoy4wc7IJZ
	cJlHQ8tRnR6/ztMEMcQMenVYHze0qN1V3O9Do273b+StZJWM8mP94YGezpPI8i5IZC4Fsk
	0HdSSX5+6Y9RcvNGlJb93gFIjEaRAWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770209788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pFsO8VEkqNeQuzb+W7X/xq1SeWJK3QNdFbLN+DmM9U=;
	b=jZnWLqXfJ/UIsuj8rRtYQJjsn9GEFY477zNDYcCBDmBBk6oh/JYiKj8nKYAlGk4yYCYnBy
	qfNsI1TqVOrnI9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961153EA63;
	Wed,  4 Feb 2026 12:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xBahJPxBg2ncZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Feb 2026 12:56:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45E61A09D8; Wed,  4 Feb 2026 13:56:28 +0100 (CET)
Date: Wed, 4 Feb 2026 13:56:28 +0100
From: Jan Kara <jack@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: shuah@kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete
 event test
Message-ID: <dnncglg3x26gdsshcniw5yb4l2zlxz6qcwjqyekkpngb6v26q4@ftqnoe5eeapy>
References: <20260203181549.21750-1-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203181549.21750-1-always.starving0@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76316-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C0B6E61D8
X-Rspamd-Action: no action

Hello!

On Wed 04-02-26 03:15:43, Jinseok Kim wrote:
> Currently there are almost no automated selftests for fanotify notification
> events in tools/testing/selftests/ (only mount namespace
> related tests exist).

Thanks for the patch but we have a very comprehensive tests for inotify and
fanotify in LTP so I don't see a reason to duplicate those inside the
kernel...

								Honza

> 
> This patch adds a very basic selftest that exercises three fundamental
> fanotify events:
>     - FAN_CREATE (file creation)
>     - FAN_MODIFY (file content modification via write())
>     - FAN_DELETE (file removal)
> 
> The test
>     - creates a test file, appends data, and removes it
>     - verifies that corresponding events are received and the masks contain
>       the expected bits (0x100, 0x2, 0x200)
> 
> Test TAP output:
>     ok 1 FAN_CREATE detected
>     ok 2 FAN_MODIFY detected
>     ok 3 FAN_DELETE detected
>     # PASSED: 1 / 1 tests passed.
> 
> This is intentionally kept minimal as a starting point.
> 
> Future work ideas (not in this patch):
>     - Test permission events
>     - Test rename/move events
>     - Verify file names
>     - Run under different filesystems
> 
> Any feedback on the direction, style, or additional test cases
> would be greatly appreciated.
> 
> Thanks,
> Jinseok.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  tools/testing/selftests/filesystems/Makefile  |   7 +
>  .../selftests/filesystems/fanotify_basic.c    | 122 ++++++++++++++++++
>  2 files changed, 129 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/fanotify_basic.c
> 
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> new file mode 100644
> index 0000000..c0e0242
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += $(KHDR_INCLUDES)
> +TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog fanotify_basic
> +TEST_GEN_PROGS_EXTENDED := dnotify_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/filesystems/fanotify_basic.c b/tools/testing/selftests/filesystems/fanotify_basic.c
> new file mode 100644
> index 0000000..4a4fbb4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fanotify_basic.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <sys/fanotify.h>
> +#include <linux/fanotify.h>
> +#include "../kselftest_harness.h"
> +#include "wrappers.h"
> +
> +static void create_file(const char *filename)
> +{
> +	int fd;
> +	int ret;
> +
> +	fd = open(filename, O_CREAT | O_WRONLY | O_TRUNC, 0644);
> +	if (fd == -1)
> +		ksft_exit_fail_msg("(create)open failed: %s\n", strerror(errno));
> +	ret = write(fd, "create_file", 11);
> +	if (ret == -1)
> +		ksft_exit_fail_msg("(create) writing failed: %s\n", strerror(errno));
> +	close(fd);
> +}
> +
> +static void modify_file(const char *filename)
> +{
> +	int fd;
> +	int ret;
> +
> +	fd = open(filename, O_RDWR);
> +	if (fd == -1)
> +		ksft_exit_fail_msg("(modify)open failed :%s\n", strerror(errno));
> +	if (lseek(fd, 0, SEEK_END) < 0)
> +		ksft_exit_fail_msg("(modify)lseek failed");
> +	ret = write(fd, "modify_file", 11);
> +	if (ret == -1)
> +		ksft_exit_fail_msg("(modify)write failed :%s\n", strerror(errno));
> +	if (fsync(fd) == -1)
> +		ksft_exit_fail_msg("(modify)fsync failed: %s\n", strerror(errno));
> +
> +	close(fd);
> +}
> +
> +TEST(fanotify_cud_test)
> +{
> +	int fan_fd;
> +	char buf[4096];
> +	int ret;
> +	ssize_t len;
> +	struct fanotify_event_metadata *meta;
> +
> +	fan_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +	ASSERT_GE(fan_fd, 0)
> +	TH_LOG("fanotify_init failed: %s", strerror(errno));
> +
> +	ret = fanotify_mark(fan_fd, FAN_MARK_ADD,
> +				  FAN_EVENT_ON_CHILD | FAN_CREATE |
> +				  FAN_MODIFY | FAN_DELETE,
> +				  AT_FDCWD, "/tmp");
> +	ASSERT_GE(ret, 0)
> +	TH_LOG("fanotify_mark failed: %s", strerror(errno));
> +
> +	// FAN_CREATE Test
> +	create_file("/tmp/fanotify_test");
> +	len = read(fan_fd, buf, sizeof(buf));
> +	ASSERT_GT(len, 0)
> +	TH_LOG("No event after create_file");
> +
> +	meta = (void *)buf;
> +	if (FAN_EVENT_OK(meta, len)) {
> +		TH_LOG("Event after create: mask = 0x%llx, pid=%d",
> +		       (unsigned long long)meta->mask, meta->pid);
> +		if (meta->mask & FAN_CREATE)
> +			ksft_test_result_pass("FAN_CREATE detected\n");
> +		else
> +			TH_LOG("FAN_CREATE missing");
> +	} else
> +		ksft_test_result_fail("Invalid event metadata after create\n");
> +
> +	// FAN_MODIFY Test
> +	modify_file("/tmp/fanotify_test");
> +	len = read(fan_fd, buf, sizeof(buf));
> +	ASSERT_GT(len, 0)
> +		TH_LOG("No event after modify_file");
> +
> +	meta = (void *)buf;
> +	if (FAN_EVENT_OK(meta, len)) {
> +		TH_LOG("Event after modify: mask = 0x%llx, pid=%d",
> +		       (unsigned long long)meta->mask, meta->pid);
> +		if (meta->mask & FAN_MODIFY)
> +			ksft_test_result_pass("FAN_MODIFY detected\n");
> +		else
> +			ksft_test_result_fail("FAN_MODIFY missing\n");
> +	} else
> +		ksft_test_result_fail("Invalid event metadata after modify\n");
> +
> +	// FAN_DELETE
> +	ASSERT_EQ(unlink("/tmp/fanotify_test"), 0)
> +		TH_LOG("unlink failed: %s", strerror(errno));
> +
> +	len = read(fan_fd, buf, sizeof(buf));
> +	ASSERT_GT(len, 0)
> +		TH_LOG("No event after unlink");
> +
> +	meta = (void *)buf;
> +	if (FAN_EVENT_OK(meta, len)) {
> +		TH_LOG("Event after delete: mask = 0x%llx, pid=%d",
> +		       (unsigned long long)meta->mask, meta->pid);
> +		if (meta->mask & FAN_DELETE)
> +			ksft_test_result_pass("FAN_DELETE detected\n");
> +		else
> +			ksft_test_result_fail("FAN_DELETE missing\n");
> +	} else
> +		ksft_test_result_fail("Invalid event metadata after delete\n");
> +
> +	// Clean up
> +	if (fan_fd >= 0) {
> +		fanotify_mark(fan_fd, FAN_MARK_REMOVE, 0, AT_FDCWD, ".");
> +		close(fan_fd);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.43.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

