Return-Path: <linux-fsdevel+bounces-43168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5821A4EDD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0B0189318B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F70259CB0;
	Tue,  4 Mar 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eqKNXvmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89A1FBEB7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117806; cv=none; b=liml+T2idHZQtsA8+RjTOZYd1tE5uEMyDLSWCRhth5Vow8k53+aKyTkJPYyrj2DsBZ1ain7xN/GBw97bo3NN5A+wf9K6p+HvgqYgUoN8anp7mSvvLyTI7b1Pqy3+M42eE+K1kjzrDIJ7LBp6ZZaWMnqQxQMpcSThUPQRbhngG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117806; c=relaxed/simple;
	bh=yDfKAyH+GCaKpGQc1vkcVE+r1lvD4JxYITriGrxVuTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1k1y6f7dKYxMdPhwz2y+GH6lF+YFykjqguSS9DYy+fjlNlzg8zkgq6C6Yd5bAX09aOFrPi5HaYnZJeA/P3p183zwoYIIqM9KVhdCkpUbjvh2cnqUInluNyW8pZ7ONlpEbsply6yQ8V57dx/zJ21Ug8eWrbt7k110K6miLmUIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eqKNXvmF; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z6mVW3fTzzx1w;
	Tue,  4 Mar 2025 20:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741117795;
	bh=gh+kioSYs8p2Adv+jc4S2MSDowL8WrsI9jdMRD+5d/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqKNXvmFQ403YWoFux39vSVyt1UEBFB0jzahhqYaQdhLIkNchh4lHvG8UAz1fOR4b
	 5cqCF1HQGWhQq6rUYrIHpU6oiboxUqUxp6fqV3e0Wr6tiwItzzDBpZWu67qVdTqA2X
	 Wu7xd6cN5xvOLw0L2QL94O5ptTiN62qsxcWYwmvs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z6mVV6v6szMvG;
	Tue,  4 Mar 2025 20:49:54 +0100 (CET)
Date: Tue, 4 Mar 2025 20:49:54 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
Message-ID: <20250304.eichiDu9iu4r@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 04, 2025 at 01:13:01AM +0000, Tingmao Wang wrote:
> The two structures are designed to be passed via read and write
> to the supervisor-fd.  Compile time check for no holes are added
> to build_check_abi.
> 
> The event structure will be a dynamically sized structure with
> possibly a NULL-terminating filename at the end.  This is so that
> we can pass a raw filename to the supervisor for file creation
> requests, without having the trouble of not being able to open a
> fd to a file that has not been created.
> 
> NOTE: despite this patch having a new uapi, I'm still very open to e.g.
> re-using fanotify stuff instead (if that makes sense in the end). This is
> just a PoC.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  include/uapi/linux/landlock.h | 107 ++++++++++++++++++++++++++++++++++
>  security/landlock/syscalls.c  |  28 +++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 7bc1eb4859fb..b5645fdd998d 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -318,4 +318,111 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
>  /* clang-format on*/
>  
> +/**
> + * DOC: supervisor
> + *
> + * Supervise mode
> + * ~~~~~~~~~~~~~~
> + *
> + * TODO
> + */
> +
> +typedef __u16 landlock_supervise_event_type_t;
> +/* clang-format off */
> +#define LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS         1
> +#define LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS        2
> +/* clang-format on */
> +
> +struct landlock_supervise_event_hdr {
> +	/**
> +	 * @type: Type of the event.
> +	 */
> +	landlock_supervise_event_type_t type;
> +	/**
> +	 * @length: Length of the entire struct
> +	 * landlock_supervise_event including this header.
> +	 */
> +	__u16 length;
> +	/**
> +	 * @cookie: Opaque identifier to be included in the response.
> +	 */
> +	__u32 cookie;

I guess we could use a __u64 index counter per layer instead.  That
would also help to order requests if they are treated by different
supervisor threads.

> +};
> +
> +struct landlock_supervise_event {
> +	struct landlock_supervise_event_hdr hdr;
> +	__u64 access_request;
> +	__kernel_pid_t accessor;
> +	union {
> +		struct {
> +			/**
> +			 * @fd1: An open file descriptor for the file (open,
> +			 * delete, execute, link, readdir, rename, truncate),
> +			 * or the parent directory (for create operations
> +			 * targeting its child) being accessed.  Must be
> +			 * closed by the reader.
> +			 *
> +			 * If this points to a parent directory, @destname
> +			 * will contain the target filename. If @destname is
> +			 * empty, this points to the target file.
> +			 */
> +			int fd1;
> +			/**
> +			 * @fd2: For link or rename requests, a second file
> +			 * descriptor for the target parent directory.  Must
> +			 * be closed by the reader.  @destname contains the
> +			 * destination filename.  This field is -1 if not
> +			 * used.
> +			 */
> +			int fd2;

Can we just use one FD but identify the requested access instead and
send one event for each, like for the audit patch series?

> +			/**
> +			 * @destname: A filename for a file creation target.
> +			 *
> +			 * If either of fd1 or fd2 points to a parent
> +			 * directory rather than the target file, this is the
> +			 * NULL-terminated name of the file that will be
> +			 * newly created.
> +			 *
> +			 * Counting the NULL terminator, this field will
> +			 * contain one or more NULL padding at the end so
> +			 * that the length of the whole struct
> +			 * landlock_supervise_event is a multiple of 8 bytes.
> +			 *
> +			 * This is a variable length member, and the length
> +			 * including the terminating NULL(s) can be derived
> +			 * from hdr.length - offsetof(struct
> +			 * landlock_supervise_event, destname).
> +			 */
> +			char destname[];

I'd prefer to avoid sending file names for now.  I don't think it's
necessary, and that could encourage supervisors to filter access
according to names.

> +		};
> +		struct {
> +			__u16 port;
> +		};
> +	};
> +};
> +

[...]

