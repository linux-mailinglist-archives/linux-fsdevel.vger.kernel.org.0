Return-Path: <linux-fsdevel+bounces-78739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NaHKAK6oWlhwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:36:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BB1B9EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 525D33054666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DD3F074C;
	Fri, 27 Feb 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="abdOL05C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="puBOlULr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="abdOL05C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="puBOlULr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3C3290A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206346; cv=none; b=dMXzi/L/aTQqP5L2Ge6TszWWCtI0lAg56xiDvef1fDv5/VCnCoTt1j9Wx40jzcEAsQFhcSGMtDmgf7OUnkwGxFjdULBm+0IuFmU8A4fx5O17slFMK8RaU7XSgJsLXUpkeinDjSsXK6d7/EdqrKuWgd861ap1/kcsdhjqrx9leW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206346; c=relaxed/simple;
	bh=p2TGSq12qURnjf+OFDnPWvwGVoYs6i+5CqpfMFFB1PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh2SvjkFDpYFtb1pxAtKOGVnJ4tn0KMCBmqAwNCa7geqhQHBbcgqMAojJDYXVvPxJlsFTD2x5ufzotTSJX/YUmzOucDknAxe2AdHNiIGOMjffFMlAurs6BR9ROuMQhVrZOjl8iKe60xrjkM7imXGI4lhYof5CbmGiuhi49sZ/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=abdOL05C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=puBOlULr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=abdOL05C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=puBOlULr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C54144016E;
	Fri, 27 Feb 2026 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiCgKQVi3dUFiUibT/uh6m3Uz8Bs/xGtX9sK7unl3iI=;
	b=abdOL05COYb01PZO0mHWmJDigRktpsMjCGPhXhge9tkF1pIDAsu+tmVq2NbNG2/h/EAT0U
	0/kRh1F4QbIY1w36hy5AK/L6oX/dB6PzWunuvoarz4Ve1cX+0IY38Y94DM9EamO0MFtuND
	R72mX13U4xmsKWgojmrpb2kQo2dBQ08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiCgKQVi3dUFiUibT/uh6m3Uz8Bs/xGtX9sK7unl3iI=;
	b=puBOlULrNvGzbYBWZU2AHhuAxNfQamn9MPCpldggVQNZiA+Za0kavZotm1JbndBnpyFYXp
	xRw2ucJvgjinMUBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiCgKQVi3dUFiUibT/uh6m3Uz8Bs/xGtX9sK7unl3iI=;
	b=abdOL05COYb01PZO0mHWmJDigRktpsMjCGPhXhge9tkF1pIDAsu+tmVq2NbNG2/h/EAT0U
	0/kRh1F4QbIY1w36hy5AK/L6oX/dB6PzWunuvoarz4Ve1cX+0IY38Y94DM9EamO0MFtuND
	R72mX13U4xmsKWgojmrpb2kQo2dBQ08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiCgKQVi3dUFiUibT/uh6m3Uz8Bs/xGtX9sK7unl3iI=;
	b=puBOlULrNvGzbYBWZU2AHhuAxNfQamn9MPCpldggVQNZiA+Za0kavZotm1JbndBnpyFYXp
	xRw2ucJvgjinMUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D2F3EA69;
	Fri, 27 Feb 2026 15:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fKmhLAa5oWk2LQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:32:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75DF6A06D4; Fri, 27 Feb 2026 16:32:22 +0100 (CET)
Date: Fri, 27 Feb 2026 16:32:22 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] selftests/xattr: test xattrs on various socket
 families
Message-ID: <i2pa5ov2voy23ap5vwbtl7ollwiw2jri2nzroethcqn4nnetrr@u2azc3pfi4qs>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-14-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-14-c2efa4f74cb7@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78739-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 208BB1B9EC0
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:10, Christian Brauner wrote:
> Test user.* xattr operations on sockets from different address families:
> AF_INET, AF_INET6, AF_NETLINK, and AF_PACKET. All socket types use
> sockfs for their inodes, so user.* xattrs should work regardless of
> address family.
> 
> Each fixture creates a socket (no bind needed) and verifies the full
> fsetxattr/fgetxattr/flistxattr/fremovexattr cycle. AF_INET6 skips if
> not supported; AF_PACKET skips if CAP_NET_RAW is unavailable.
> 
> Also tests abstract namespace AF_UNIX sockets, which live in sockfs
> (not on a filesystem) and should support user.* xattrs.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../testing/selftests/filesystems/xattr/.gitignore |   1 +
>  tools/testing/selftests/filesystems/xattr/Makefile |   2 +-
>  .../filesystems/xattr/xattr_socket_types_test.c    | 177 +++++++++++++++++++++
>  3 files changed, 179 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/xattr/.gitignore b/tools/testing/selftests/filesystems/xattr/.gitignore
> index 00a59c89efab..092d14094c0f 100644
> --- a/tools/testing/selftests/filesystems/xattr/.gitignore
> +++ b/tools/testing/selftests/filesystems/xattr/.gitignore
> @@ -1,2 +1,3 @@
>  xattr_socket_test
>  xattr_sockfs_test
> +xattr_socket_types_test
> diff --git a/tools/testing/selftests/filesystems/xattr/Makefile b/tools/testing/selftests/filesystems/xattr/Makefile
> index 2cd722dba47b..95364ffb10e9 100644
> --- a/tools/testing/selftests/filesystems/xattr/Makefile
> +++ b/tools/testing/selftests/filesystems/xattr/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += $(KHDR_INCLUDES)
> -TEST_GEN_PROGS := xattr_socket_test xattr_sockfs_test
> +TEST_GEN_PROGS := xattr_socket_test xattr_sockfs_test xattr_socket_types_test
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c b/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c
> new file mode 100644
> index 000000000000..bfabe91b2ed1
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
> +/*
> + * Test user.* xattrs on various socket families.
> + *
> + * All socket types use sockfs for their inodes, so user.* xattrs should
> + * work on any socket regardless of address family. This tests AF_INET,
> + * AF_INET6, AF_NETLINK, AF_PACKET, and abstract namespace AF_UNIX sockets.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/xattr.h>
> +#include <linux/netlink.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define TEST_XATTR_NAME		"user.testattr"
> +#define TEST_XATTR_VALUE	"testvalue"
> +
> +FIXTURE(xattr_socket_types)
> +{
> +	int sockfd;
> +};
> +
> +FIXTURE_VARIANT(xattr_socket_types)
> +{
> +	int family;
> +	int type;
> +	int protocol;
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_types, inet) {
> +	.family = AF_INET,
> +	.type = SOCK_STREAM,
> +	.protocol = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_types, inet6) {
> +	.family = AF_INET6,
> +	.type = SOCK_STREAM,
> +	.protocol = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_types, netlink) {
> +	.family = AF_NETLINK,
> +	.type = SOCK_RAW,
> +	.protocol = NETLINK_USERSOCK,
> +};
> +
> +FIXTURE_VARIANT_ADD(xattr_socket_types, packet) {
> +	.family = AF_PACKET,
> +	.type = SOCK_DGRAM,
> +	.protocol = 0,
> +};
> +
> +FIXTURE_SETUP(xattr_socket_types)
> +{
> +	self->sockfd = socket(variant->family, variant->type,
> +			      variant->protocol);
> +	if (self->sockfd < 0 &&
> +	    (errno == EAFNOSUPPORT || errno == EPERM || errno == EACCES))
> +		SKIP(return, "socket(%d, %d, %d) not available: %s",
> +		     variant->family, variant->type, variant->protocol,
> +		     strerror(errno));
> +	ASSERT_GE(self->sockfd, 0) {
> +		TH_LOG("Failed to create socket(%d, %d, %d): %s",
> +		       variant->family, variant->type, variant->protocol,
> +		       strerror(errno));
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(xattr_socket_types)
> +{
> +	if (self->sockfd >= 0)
> +		close(self->sockfd);
> +}
> +
> +TEST_F(xattr_socket_types, set_get_list_remove)
> +{
> +	char buf[256], list[4096], *ptr;
> +	ssize_t ret;
> +	bool found;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("fsetxattr failed: %s", strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
> +
> +	memset(list, 0, sizeof(list));
> +	ret = flistxattr(self->sockfd, list, sizeof(list));
> +	ASSERT_GT(ret, 0);
> +	found = false;
> +	for (ptr = list; ptr < list + ret; ptr += strlen(ptr) + 1) {
> +		if (strcmp(ptr, TEST_XATTR_NAME) == 0)
> +			found = true;
> +	}
> +	ASSERT_TRUE(found);
> +
> +	ret = fremovexattr(self->sockfd, TEST_XATTR_NAME);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ENODATA);
> +}
> +
> +/*
> + * Test abstract namespace AF_UNIX socket.
> + * Abstract sockets don't have a filesystem path; their inodes live in
> + * sockfs so user.* xattrs should work via fsetxattr/fgetxattr.
> + */
> +FIXTURE(xattr_abstract)
> +{
> +	int sockfd;
> +};
> +
> +FIXTURE_SETUP(xattr_abstract)
> +{
> +	struct sockaddr_un addr;
> +	char name[64];
> +	int ret, len;
> +
> +	self->sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	ASSERT_GE(self->sockfd, 0);
> +
> +	len = snprintf(name, sizeof(name), "xattr_test_abstract_%d", getpid());
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	addr.sun_path[0] = '\0';
> +	memcpy(&addr.sun_path[1], name, len);
> +
> +	ret = bind(self->sockfd, (struct sockaddr *)&addr,
> +		   offsetof(struct sockaddr_un, sun_path) + 1 + len);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +FIXTURE_TEARDOWN(xattr_abstract)
> +{
> +	if (self->sockfd >= 0)
> +		close(self->sockfd);
> +}
> +
> +TEST_F(xattr_abstract, set_get)
> +{
> +	char buf[256];
> +	ssize_t ret;
> +
> +	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
> +			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("fsetxattr on abstract socket failed: %s",
> +		       strerror(errno));
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
> +	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
> +	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
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

