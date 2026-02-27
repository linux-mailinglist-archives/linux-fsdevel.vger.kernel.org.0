Return-Path: <linux-fsdevel+bounces-78737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDJwCui5oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:36:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CE1B9EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C7F30DE1B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A00438FED;
	Fri, 27 Feb 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NG/NPYOd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hiMBeIfE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLpE28ZI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDVNoDij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D6438FE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206153; cv=none; b=KwSB0n2z2YNGQer+j7UxmjxRVrIbyL8R+UycFWUVWlZ38V3UiftPwOrjyaTpbiWCbOH4k/fYqKWN5OYcG8XJ6RE3b4k8YIAglgm3+yDNeDrhz1+RLqm0nWtVKz5hC9X71XgK4p0JRNA/ZzrJUtdXnrxoWWkPs2+8XwwqhuBSPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206153; c=relaxed/simple;
	bh=LqT5iDxFKbNhfexuDFyunDDTlB9Bwh7B+P9NeCMq0W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3eC1pHwosK/vLdfoP2fpthvtxnfNzLam0i6kSX1yGwEUh3f+GwMbm9+2djOBlxpdOl8uqTd+uG8IoCB3rUKJZra+/IDjQWf5CULtvecYBkmy2r6DyWW5of8YWgp6729zppqHZJxbImHGYOJOcKkHgHyL4EnklXapyT5wsjcfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NG/NPYOd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hiMBeIfE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLpE28ZI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDVNoDij; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB6385C065;
	Fri, 27 Feb 2026 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bxt3l5tiOZrsL/m56OcabS6LLFiteUQfh0DGh/2AE=;
	b=NG/NPYOd8sti5Ngt6uil2JzH2VqzG3deAvGiIA+koempgfaMvVH7BPlhbdx+po54+QC+Hg
	TrTlXSRgxEYk/y/KUqHwfjsVL1tkeqpb9JeGNgaz7hvF+d9aFdjjMO0MENBwW25rjqqJHg
	7R/+XuJT0gWN6u9G8EXPny6K5V6Gzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bxt3l5tiOZrsL/m56OcabS6LLFiteUQfh0DGh/2AE=;
	b=hiMBeIfEoOZEkYGhGJW621e8zcNVwd4qknDTETzM4OAJkGE9W0ZweXRdG6UyjetZRQeWSO
	4IUZEV5iQpI8eiDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BLpE28ZI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KDVNoDij
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bxt3l5tiOZrsL/m56OcabS6LLFiteUQfh0DGh/2AE=;
	b=BLpE28ZIv2cyM4AdHPK8JIEoifMwNKNQNsxW+JUoIjOyZAFoyMIWY4Pgyt4pg4XPZRMSrB
	LDG2r/rr5PgSmefxSI6ftpvj4DLa/vfm2dJPMpFIt48gi2/lBi40EQsDK12/OrLuBO2x8g
	7BH4owg5//CXCDk459XH9KlIi7HPxAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bxt3l5tiOZrsL/m56OcabS6LLFiteUQfh0DGh/2AE=;
	b=KDVNoDijOnwG++4PBS+lCI0++vOjpCnlq+NU5tmIyL29dHRqetOMGaUAaCgY0ts7ZxFGlZ
	e9N6ry8xJAxPteDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D82803EA69;
	Fri, 27 Feb 2026 15:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSe8NES4oWnHKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:29:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93FE9A06D4; Fri, 27 Feb 2026 16:29:08 +0100 (CET)
Date: Fri, 27 Feb 2026 16:29:08 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 12/14] selftests/xattr: path-based AF_UNIX socket xattr
 tests
Message-ID: <zvdb5lqvbph3bvt5j2k77voak7xw2snkzntswnnmuv2hjq6zy6@k7bgetuq5zbn>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-12-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-12-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78737-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B8CE1B9EA4
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:08, Christian Brauner wrote:
> Test user.* extended attribute operations on path-based Unix domain
> sockets (SOCK_STREAM, SOCK_DGRAM, SOCK_SEQPACKET). Path-based sockets
> are bound to a filesystem path and their inodes live on the underlying
> filesystem (e.g. tmpfs).
> 
> Covers set/get/list/remove, persistence, XATTR_CREATE/XATTR_REPLACE
> flags, empty values, size queries, buffer-too-small errors, O_PATH fd
> operations, and trusted.* xattr handling.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../testing/selftests/filesystems/xattr/.gitignore |   1 +
>  tools/testing/selftests/filesystems/xattr/Makefile |   6 +
>  .../filesystems/xattr/xattr_socket_test.c          | 470 +++++++++++++++++++++
>  3 files changed, 477 insertions(+)
> 
> diff --git a/tools/testing/selftests/filesystems/xattr/.gitignore b/tools/testing/selftests/filesystems/xattr/.gitignore
> new file mode 100644
> index 000000000000..5fd015d2257a
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/xattr/.gitignore
> @@ -0,0 +1 @@
> +xattr_socket_test
> diff --git a/tools/testing/selftests/filesystems/xattr/Makefile b/tools/testing/selftests/filesystems/xattr/Makefile
> new file mode 100644
> index 000000000000..e3d8dca80faa
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/xattr/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += $(KHDR_INCLUDES)
> +TEST_GEN_PROGS := xattr_socket_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/xattr/xattr_socket_test.c b/tools/testing/selftests/filesystems/xattr/xattr_socket_test.c
> new file mode 100644
> index 000000000000..fac0a4c6bc05
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/xattr/xattr_socket_test.c
> @@ -0,0 +1,470 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
> +/*
> + * Test extended attributes on path-based Unix domain sockets.
> + *
> + * Path-based Unix domain sockets are bound to a filesystem path and their
> + * inodes live on the underlying filesystem (e.g. tmpfs). These tests verify
> + * that user.* and trusted.* xattr operations work correctly on them using
> + * path-based syscalls (setxattr, getxattr, etc.).
> + *
> + * Covers SOCK_STREAM, SOCK_DGRAM, and SOCK_SEQPACKET socket types.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/xattr.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define TEST_XATTR_NAME		"user.testattr"
> +#define TEST_XATTR_VALUE	"testvalue"
> +#define TEST_XATTR_VALUE2	"newvalue"
> +
> +/*
> + * Fixture for path-based Unix domain socket tests.
> + * Creates a SOCK_STREAM socket bound to a path in /tmp (typically tmpfs).
> + */
> +FIXTURE(xattr_socket)
> +{
> +	char socket_path[PATH_MAX];
> +	int sockfd;
> +};
> +
> +FIXTURE_VARIANT(xattr_socket)
> +{
> +	int sock_type;
> +	const char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket, stream) {
> +	.sock_type = SOCK_STREAM,
> +	.name = "stream",
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket, dgram) {
> +	.sock_type = SOCK_DGRAM,
> +	.name = "dgram",
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket, seqpacket) {
> +	.sock_type = SOCK_SEQPACKET,
> +	.name = "seqpacket",
> +};
> +
> +FIXTURE_SETUP(xattr_socket)
> +{
> +	struct sockaddr_un addr;
> +	int ret;
> +
> +	self->sockfd = -1;
> +
> +	snprintf(self->socket_path, sizeof(self->socket_path),
> +		 "/tmp/xattr_socket_test_%s.%d", variant->name, getpid());
> +	unlink(self->socket_path);
> +
> +	self->sockfd = socket(AF_UNIX, variant->sock_type, 0);
> +	ASSERT_GE(self->sockfd, 0) {
> +		TH_LOG("Failed to create socket: %s", strerror(errno));
> +	}
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	strncpy(addr.sun_path, self->socket_path, sizeof(addr.sun_path) - 1);
> +
> +	ret = bind(self->sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("Failed to bind socket to %s: %s",
> +		       self->socket_path, strerror(errno));
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(xattr_socket)
> +{
> +	if (self->sockfd >= 0)
> +		close(self->sockfd);
> +	unlink(self->socket_path);
> +}
> +
> +TEST_F(xattr_socket, set_user_xattr)
> +{
> +	int ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr failed: %s (errno=%d)", strerror(errno), errno);
> +	}
> +}
> +
> +TEST_F(xattr_socket, get_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE)) {
> +		TH_LOG("getxattr returned %zd, expected %zu: %s",
> +		       ret, strlen(TEST_XATTR_VALUE), strerror(errno));
> +	}
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +}
> +
> +TEST_F(xattr_socket, list_user_xattr)
> +{
> +	char list[1024];
> +	ssize_t ret;
> +	bool found = false;
> +	char *ptr;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(list, 0, sizeof(list));
> +	ret = listxattr(self->socket_path, list, sizeof(list));
> +	ASSERT_GT(ret, 0) {
> +		TH_LOG("listxattr failed: %s", strerror(errno));
> +	}
> +
> +	for (ptr = list; ptr < list + ret; ptr += strlen(ptr) + 1) {
> +		if (strcmp(ptr, TEST_XATTR_NAME) == 0) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	ASSERT_TRUE(found) {
> +		TH_LOG("xattr %s not found in list", TEST_XATTR_NAME);
> +	}
> +}
> +
> +TEST_F(xattr_socket, remove_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr failed: %s", strerror(errno));
> +	}
> +
> +	ret = removexattr(self->socket_path, TEST_XATTR_NAME);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("removexattr failed: %s", strerror(errno));
> +	}
> +
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA) {
> +		TH_LOG("Expected ENODATA, got %s", strerror(errno));
> +	}
> +}
> +
> +/*
> + * Test that xattrs persist across socket close and reopen.
> + * The xattr is on the filesystem inode, not the socket fd.
> + */
> +TEST_F(xattr_socket, xattr_persistence)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr failed: %s", strerror(errno));
> +	}
> +
> +	close(self->sockfd);
> +	self->sockfd = -1;
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE)) {
> +		TH_LOG("getxattr after close failed: %s", strerror(errno));
> +	}
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +}
> +
> +TEST_F(xattr_socket, update_user_xattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE2, strlen(TEST_XATTR_VALUE2), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE2));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE2);
> +}
> +
> +TEST_F(xattr_socket, xattr_create_flag)
> +{
> +	int ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE2, strlen(TEST_XATTR_VALUE2), XATTR_CREATE);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EEXIST);
> +}
> +
> +TEST_F(xattr_socket, xattr_replace_flag)
> +{
> +	int ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), XATTR_REPLACE);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_socket, multiple_xattrs)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +	int i;
> +	char name[64], value[64];
> +	const int num_xattrs = 5;
> +
> +	for (i = 0; i < num_xattrs; i++) {
> +		snprintf(name, sizeof(name), "user.test%d", i);
> +		snprintf(value, sizeof(value), "value%d", i);
> +		ret = setxattr(self->socket_path, name, value, strlen(value), 0);
> +		ASSERT_EQ(ret, 0) {
> +			TH_LOG("setxattr %s failed: %s", name, strerror(errno));
> +		}
> +	}
> +
> +	for (i = 0; i < num_xattrs; i++) {
> +		snprintf(name, sizeof(name), "user.test%d", i);
> +		snprintf(value, sizeof(value), "value%d", i);
> +		memset(buf, 0, sizeof(buf));
> +		ret = getxattr(self->socket_path, name, buf, sizeof(buf));
> +		ASSERT_EQ(ret, (ssize_t)strlen(value));
> +		ASSERT_STREQ(buf, value);
> +	}
> +}
> +
> +TEST_F(xattr_socket, xattr_empty_value)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME, "", 0, 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_F(xattr_socket, xattr_get_size)
> +{
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, NULL, 0);
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +}
> +
> +TEST_F(xattr_socket, xattr_buffer_too_small)
> +{
> +	char buf[2];
> +	ssize_t ret;
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ERANGE);
> +}
> +
> +TEST_F(xattr_socket, xattr_nonexistent)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = getxattr(self->socket_path, "user.nonexistent", buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_socket, remove_nonexistent_xattr)
> +{
> +	int ret;
> +
> +	ret = removexattr(self->socket_path, "user.nonexistent");
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +TEST_F(xattr_socket, large_xattr_value)
> +{
> +	char large_value[4096];
> +	char read_buf[4096];
> +	ssize_t ret;
> +
> +	memset(large_value, 'A', sizeof(large_value));
> +
> +	ret = setxattr(self->socket_path, TEST_XATTR_NAME,
> +		       large_value, sizeof(large_value), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr with large value failed: %s", strerror(errno));
> +	}
> +
> +	memset(read_buf, 0, sizeof(read_buf));
> +	ret = getxattr(self->socket_path, TEST_XATTR_NAME,
> +		       read_buf, sizeof(read_buf));
> +	ASSERT_EQ(ret, (ssize_t)sizeof(large_value));
> +	ASSERT_EQ(memcmp(large_value, read_buf, sizeof(large_value)), 0);
> +}
> +
> +/*
> + * Test lsetxattr/lgetxattr (don't follow symlinks).
> + * Socket files aren't symlinks, so this should work the same.
> + */
> +TEST_F(xattr_socket, lsetxattr_lgetxattr)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = lsetxattr(self->socket_path, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("lsetxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = lgetxattr(self->socket_path, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +}
> +
> +/*
> + * Fixture for trusted.* xattr tests.
> + * These require CAP_SYS_ADMIN.
> + */
> +FIXTURE(xattr_socket_trusted)
> +{
> +	char socket_path[PATH_MAX];
> +	int sockfd;
> +};
> +
> +FIXTURE_VARIANT(xattr_socket_trusted)
> +{
> +	int sock_type;
> +	const char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_trusted, stream) {
> +	.sock_type = SOCK_STREAM,
> +	.name = "stream",
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_trusted, dgram) {
> +	.sock_type = SOCK_DGRAM,
> +	.name = "dgram",
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_trusted, seqpacket) {
> +	.sock_type = SOCK_SEQPACKET,
> +	.name = "seqpacket",
> +};
> +
> +FIXTURE_SETUP(xattr_socket_trusted)
> +{
> +	struct sockaddr_un addr;
> +	int ret;
> +
> +	self->sockfd = -1;
> +
> +	snprintf(self->socket_path, sizeof(self->socket_path),
> +		 "/tmp/xattr_socket_trusted_%s.%d", variant->name, getpid());
> +	unlink(self->socket_path);
> +
> +	self->sockfd = socket(AF_UNIX, variant->sock_type, 0);
> +	ASSERT_GE(self->sockfd, 0);
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	strncpy(addr.sun_path, self->socket_path, sizeof(addr.sun_path) - 1);
> +
> +	ret = bind(self->sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +FIXTURE_TEARDOWN(xattr_socket_trusted)
> +{
> +	if (self->sockfd >= 0)
> +		close(self->sockfd);
> +	unlink(self->socket_path);
> +}
> +
> +TEST_F(xattr_socket_trusted, set_trusted_xattr)
> +{
> +	char buf[256];
> +	ssize_t len;
> +	int ret;
> +
> +	ret = setxattr(self->socket_path, "trusted.testattr",
> +		       TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	if (ret == -1 && errno == EPERM)
> +		SKIP(return, "Need CAP_SYS_ADMIN for trusted.* xattrs");
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("setxattr trusted.testattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	len = getxattr(self->socket_path, "trusted.testattr",
> +		       buf, sizeof(buf));
> +	ASSERT_EQ(len, (ssize_t)strlen(TEST_XATTR_VALUE));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +}
> +
> +TEST_F(xattr_socket_trusted, get_trusted_xattr_unprivileged)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = getxattr(self->socket_path, "trusted.testattr", buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_TRUE(errno == ENODATA || errno == EPERM) {
> +		TH_LOG("Expected ENODATA or EPERM, got %s", strerror(errno));
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

