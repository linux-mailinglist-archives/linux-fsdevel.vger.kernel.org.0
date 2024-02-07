Return-Path: <linux-fsdevel+bounces-10687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09D84D606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF171C22483
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D81CF95;
	Wed,  7 Feb 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CcibzvA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60D149E1E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346070; cv=none; b=gCRVzZxmTUVGfEImG7TvtNc7NOwL0hfSBuz09XVeaeirEm4exYtzyvOhwlm0APiQAhTBWdrWzd+cJ8d82kgsBJ5vGMjmDAZS1XD3FztDxYtfKpLY51KJwPeVCpCqGwsRmAiDnvE6NrtYilMXsdLMxl/5QFiWuOgHRBtHo56X3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346070; c=relaxed/simple;
	bh=2IeVxJD11bZboYXSxaJt99cyQfzvtvgmfU0yMtgbm14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iikG+WJu5T6LhL08NcEHC6bJC9SA54y12C6w+eFdB0dALNDHeDCJ7f/lVP/rOsUMl5x96slvfB5V8wUfBt+N8UiaUm2UOht/DqD3anNu1sgLcvRDNBnfchxtfB4ks9nCTKwWAB7ajM1nbel/3jOQqYeW7AT3rC8PkIdJtuopNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CcibzvA9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d958e0d73dso2760555ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707346068; x=1707950868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuWnV2HSxDx4Y3vF/bwrU8AX6E0zJJ7Ppqa0xkv57Pk=;
        b=CcibzvA96LF0Ttzd2fQ0B3YptJUvWw2oWHTYWkhUoJOE+JNZyGkWD5QkEm+a8tFp8b
         PSyf7s3uF3mw2vnUfB2jb5HsDbaElfDBYxOINt5EDlvRC/1qIaCYROwqmBYsmJePe9xI
         bj8MpOxrpYyUNC1nfjEy9W5louWhuNzZuboLcYPvKH9Zq4r6BRw/pGyE8VAQ7GnXKqaF
         +FW0ipdm+RNgiUkZi3lYl4wRgmHAy6bh06mHd3aS+zB8McrGIU33lAAxH+nmmQwILTyq
         q0Cw/L2SB/IMxFUCs5nw2ZkRgXC+mrmIAWDQkOncuQpsbzrM7EfuVLSS9Ha3ovtVS0Nt
         N5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346068; x=1707950868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuWnV2HSxDx4Y3vF/bwrU8AX6E0zJJ7Ppqa0xkv57Pk=;
        b=gPxT2aNpqS0hyNaAOFcyghNmHlV+cR4uluIHlIc/Xtt1TvJAJ6owh59VirED+OLpsN
         L09rZLiDgNRKwo5WqPZrV7G2VZBHZeZ0cIA24NJEM6kmXuzvHhxtoslbvgvZBQVpX53L
         1oNdV4gZO9pL4jMs+/zHwPcVl2eo3wbG8aAtSva7BjAgH02WnmBxV1uLRkoYTJxr04zT
         eZyKZmOApdDU7dyhmQXOshNKxWkSpiUbMBv2bG0YKA10N4knZRp74nsdAXqXYWVxB4K4
         0seFmWGUYbd3T8yAGgXMWDTtWTCNQ0ShNNAzoMVf8YUbaEw/du2VeoTDBjvtVcF7HnQg
         zqVA==
X-Gm-Message-State: AOJu0YzHPNgmEq5gI5TB57jk8dlH+ZIQxwOl7zXKIbcdsRo6yC3n3emC
	O02RUusJSeN7YX+h7cDFPFvfjJNlV339WKTIJJtRtc3+9mKZ/7Y7yFidRx1D7GE=
X-Google-Smtp-Source: AGHT+IEwrXY3eND9BU6k1rUyY3PXIw2fUPRgSZ9y1MGVxPYq7kB2GUAOXbxLFqDfRIBCazJHIMA7kg==
X-Received: by 2002:a17:902:ef93:b0:1d7:57e1:5202 with SMTP id iz19-20020a170902ef9300b001d757e15202mr1200569plb.20.1707346068266;
        Wed, 07 Feb 2024 14:47:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNwYT4/IDJGzcIe3lMykQg78SXQNAldqzyywnopbYuDBvfe3c+lTeLmzLhuV2Rqv7GXksaSWLL7gw5gO9HFnX+Wcsp3i2b7pQL49f14vDsubhKwjoBV7SXqdmwB9tCzSUTocDpgIuQKtN7TwnsMkrqcGO3pe89K2I=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id n21-20020a638f15000000b005d6c208fbd2sm2195587pgd.35.2024.02.07.14.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:47:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXqhl-003SsX-11;
	Thu, 08 Feb 2024 09:47:45 +1100
Date: Thu, 8 Feb 2024 09:47:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Timur Tabi <ttabi@nvidia.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"michael@ellerman.id.au" <michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Message-ID: <ZcQIkejkOoQy8lrR@dread.disaster.area>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
 <ZcP4xsiohW7jOe78@dread.disaster.area>
 <6f7565b9d38a6a9bddb407462ae53eb2ceaf0323.camel@nvidia.com>
 <ZcP+3gqQ+LDLt1SP@dread.disaster.area>
 <33f582cce59ac14ce454aa49e14f50e535684004.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f582cce59ac14ce454aa49e14f50e535684004.camel@nvidia.com>

On Wed, Feb 07, 2024 at 10:18:26PM +0000, Timur Tabi wrote:
> On Thu, 2024-02-08 at 09:06 +1100, Dave Chinner wrote:
> > So fix the debugfs_create_file_*() functions to pass a length
> > and that way you fix all the "debugfs files have zero length but
> > still have data that can be read" problems for everyone? Then the
> > zero length problem can be isolated to just the debug objects that don't
> > know their size (i.e. are streams of data, not fixed size).
> > 
> > IMO, it doesn't help anyone to have one part of the debugfs
> > blob/file API to set inode->i_size correctly, but then leave the
> > majority of the users still behaving the problematic way (i.e. zero
> > size yet with data that can be read). It's just a recipe for
> > confusion....
> 
> I don't disagree, but that's a much more ambitious change than I am prepared
> to make.  

TANSTAAFL.

"That's somebody else's problem" is what everyone says about fixing
problems once they've worked out the minimal fix that addresses
their specific issue.

We need a new rule: do not leave technical debt behind that other
people will still have to clean up after you get what you need.

> debugfs_create_file_size() already exists, it's just that
> debugfs_create_blob() doesn't use it.  I think the problem is that the file
> size is not always known, or at least not always the fixed, so setting the
> initial file size isn't always an option.

Yes, that's exactly what I said:

"Then the zero length problem can be isolated to just the debug
objects that don't know their size (i.e. are streams of data, not
fixed size)."

Make the majority behave correctly by default, force those that want
a file to work like a stream to explicitly say they want a zero
sized debugfs file.

Indeed - those that want a stream should call a helper function like
debugfs_create_data_stream() to indicate what is emitted from that
file is an unknown amount of data, and that it should be read until
no more data is present by userspace.

The hack of using zero length files for these can then be hidden
behind the API that documents exactly the type of data being
exported by the subsystem....

> On a side note, debugfs_create_file_size() does the same thing that my v1
> patch does:
> 
> struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
> if (!IS_ERR(de))
> 	d_inode(de)->i_size = file_size;
> 
> Shouldn't this function also use i_size_write()?

Yes, it should.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

