Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F1226F24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgGTTkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 15:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTTkd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:40:33 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328B920672;
        Mon, 20 Jul 2020 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595274032;
        bh=lAH/pO7NHoNYrDfJluSLCpW3uOX8+hweYMlfZ1rH62Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xintglz7XrZi1QsSOvZaC1N4Gx4Y0EBpdxbtteU3G7LoI/O6Cy9epxk2ektQ5pK1I
         GmAWXF+s74OAODL31vHTzmZ8JGtJHWc/hpKps/NK/BV+9jEoO69bK7NXwh9vKWQBjG
         bEHvuN4oIUxfjPkvNMRfQ6Ba/4N/GAqUL3xNfgq8=
Date:   Mon, 20 Jul 2020 12:40:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 7/7] fscrypt: update documentation for direct I/O
 support
Message-ID: <20200720194030.GI1292162@gmail.com>
References: <20200717014540.71515-1-satyat@google.com>
 <20200717014540.71515-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717014540.71515-8-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:45:40AM +0000, Satya Tangirala wrote:
> Update fscrypt documentation to reflect the addition of direct I/O support
> and document the necessary conditions for direct I/O on encrypted files.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index f3d87a1a0a7f..95c76a5f0567 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
>    may be used to overwrite the source files but isn't guaranteed to be
>    effective on all filesystems and storage devices.
>  
> -- Direct I/O is not supported on encrypted files.  Attempts to use
> -  direct I/O on such files will fall back to buffered I/O.
> +- Direct I/O is supported on encrypted files only under some circumstances
> +  (see `Direct I/O support`_ for details). When these circumstances are not
> +  met, attempts to use direct I/O on such files will fall back to buffered
> +  I/O.

Nit: "such files" => "encrypted files".

Nit: most of the text in this file is formatted with textwidth=70.

>  
>  - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
>    FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
> @@ -1257,6 +1259,20 @@ without the key is subject to change in the future.  It is only meant
>  as a way to temporarily present valid filenames so that commands like
>  ``rm -r`` work as expected on encrypted directories.
>  
> +Direct I/O support
> +------------------
> +
> +Direct I/O on encrypted files is supported through blk-crypto. In
> +particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
> +enabled, the filesystem must have had the 'inlinecrypt' mount option
> +specified, and either hardware inline encryption must be present, or
> +CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
> +any I/O must be aligned to the filesystem block size (*not* necessarily
> +the same as the block device's block size) - in particular, any userspace
> +buffer into which data is read/written from must also be aligned to the
> +filesystem block size. If any of these conditions isn't met, attempts to do
> +direct I/O on an encrypted file will fall back to buffered I/O.

This is placing "Direct I/O support" as a subsection of the
"Implementation details" section.

But the direct I/O support is more than just an implementation detail.

How about moving it to a top-level section?

I'd probably put it between "Access semantics" and
"Encryption policy enforcement".

- Eric
