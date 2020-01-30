Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF014D5A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 05:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA3EdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 23:33:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726771AbgA3EdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580358797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOaFQL6Nzm8OiPjWEUa02hgCjlBIo20DODkhhF5ZVIo=;
        b=S9cxp74eiANTN3Uw4knSa+kaeUZembLmKXveWZE0rEvZu5qTpiKgGlOvBBhwJSJKwAbvUy
        HfEB/r2+LrT5/DQcJd+kQ1P1ssrDFfhYt2wTe2cp6fyYaPmlGcgedgmCL/mG5b/auxjPwl
        eCHTplplzoc/xEeQjtbQUc06TeOFuxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-NtIM4A5uM4icka3YrZ0dGA-1; Wed, 29 Jan 2020 23:33:15 -0500
X-MC-Unique: NtIM4A5uM4icka3YrZ0dGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CA9CA0CBF;
        Thu, 30 Jan 2020 04:33:14 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 976EA19756;
        Thu, 30 Jan 2020 04:33:13 +0000 (UTC)
Date:   Thu, 30 Jan 2020 12:42:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH xfsprogs] xfs_io: add support for linkat()
 AT_LINK_REPLACE
Message-ID: <20200130044251.GL14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <cover.1580251857.git.osandov@fb.com>
 <ff4b873f356ed8ff63ee582bc57c4babea947159.1580253398.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff4b873f356ed8ff63ee582bc57c4babea947159.1580253398.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:58:29AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

And this patch would be better to send to/cc linux-xfs@vger.kernel.org to get
xfsprogs maintainers/developers review.

>  io/link.c         | 24 ++++++++++++++++++++----
>  man/man8/xfs_io.8 |  9 ++++++++-
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/io/link.c b/io/link.c
> index f4f4b139..3fc3e24d 100644
> --- a/io/link.c
> +++ b/io/link.c
> @@ -12,6 +12,9 @@
>  #ifndef AT_EMPTY_PATH
>  #define AT_EMPTY_PATH	0x1000
>  #endif
> +#ifndef AT_LINK_REPLACE
> +#define AT_LINK_REPLACE	0x10000
> +#endif
>  
>  static cmdinfo_t flink_cmd;
>  
> @@ -22,6 +25,7 @@ flink_help(void)
>  "\n"
>  "link the open file descriptor to the supplied filename\n"
>  "\n"
> +" -f -- overwrite the target filename if it exists (AT_LINK_REPLACE)\n"
>  "\n"));
>  }
>  
> @@ -30,10 +34,22 @@ flink_f(
>  	int		argc,
>  	char		**argv)
>  {
> -	if (argc != 2)
> +	int		flags = AT_EMPTY_PATH;
> +	int		c;
> +
> +	while ((c = getopt(argc, argv, "f")) != EOF) {
> +		switch (c) {
> +		case 'f':
> +			flags |= AT_LINK_REPLACE;
> +			break;
> +		default:
> +			return command_usage(&flink_cmd);
> +		}
> +	}
> +	if (optind != argc - 1)
>  		return command_usage(&flink_cmd);
>  
> -	if (linkat(file->fd, "", AT_FDCWD, argv[1], AT_EMPTY_PATH) < 0) {
> +	if (linkat(file->fd, "", AT_FDCWD, argv[optind], flags) < 0) {
>  		perror("flink");
>  		return 0;
>  	}
> @@ -46,9 +62,9 @@ flink_init(void)
>  	flink_cmd.name = "flink";
>  	flink_cmd.cfunc = flink_f;
>  	flink_cmd.argmin = 1;
> -	flink_cmd.argmax = 1;
> +	flink_cmd.argmax = -1;
>  	flink_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK | CMD_FLAG_ONESHOT;
> -	flink_cmd.args = _("filename");
> +	flink_cmd.args = _("[-f] filename");
>  	flink_cmd.oneline =
>  		_("link the open file descriptor to the supplied filename");
>  	flink_cmd.help = flink_help;
> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> index c69b295d..f79b3a59 100644
> --- a/man/man8/xfs_io.8
> +++ b/man/man8/xfs_io.8
> @@ -807,8 +807,15 @@ for the full list) is available via the
>  .B help
>  command.
>  .TP
> -.BI "flink " path
> +.BI "flink [ \-f ]" " path"
>  Link the currently open file descriptor into the filesystem namespace.
> +.RS 1.0i
> +.PD 0
> +.TP 0.4i
> +.B \-f
> +overwrite the target path if it exists (AT_LINK_REPLACE).
> +.PD
> +.RE
>  .TP
>  .BR stat " [ " \-v "|" \-r " ]"
>  Selected statistics from
> -- 
> 2.25.0
> 

