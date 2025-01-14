Return-Path: <linux-fsdevel+bounces-39203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2C3A11574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9F73A1A58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30658215069;
	Tue, 14 Jan 2025 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AZRfclU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135220F077
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897572; cv=none; b=JZvcjoGQWiltkL0dH5hWe93+4r0RrBi550lQ/rL+N9mJW+v0Y/uf1WDZ/ALQFjXJT9yWLGV0h4JA2M397WQGPnqNQeTgS3eFMkJ3w7CxCfAvqEKCEgh/fzyPfo7UG+AJnv9kzjqTG3y51tUFNoUEApGMxUyungl9bRIzZqfZRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897572; c=relaxed/simple;
	bh=EH4RLqsDVF9zSUks6UrRLaqphy/hbeH6z3cPBC+YP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6Sj/yHoEctiqsBihbicqHZnlaSgl+8Pst1Ual6KqExkLTCi093+jjNJavoc4QinBJyRRq3aDeiP2vvvA2Empclu1klJ+lHiHD5sHW1Ia84g5erq11UOfTHUvNKjeS5DlrX9vb4V0v7jGv1Wftx3FiumcxUzW5RKvrmaRDdVoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AZRfclU9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so105596205ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736897570; x=1737502370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VPYIbHVE1it102on3lTKA/uIDG+wS+cqUn+a2PGr4p4=;
        b=AZRfclU96UGExG6klDK8eIBDZw4ukmCgX9OCrgqLvkQAaIwcxWlt6y1QSNPiluCu4N
         ceU5Vnm9VUkJ2tNiLl+9OBV21uOoZqM3t2rmhW3r4JlQmPnOALRVHF4WQtKbtANap40d
         UAqK2oHwbAlGbB4rbvztzzCcbtpJ2cNMsd0n9M03QToTuUptm0XgFFztEahxLP+fxBh+
         rMW58r9AYJMVAfdGpHuj9ilQJxUz0SjBuHjoXk2cS8ri+b9PFUXCOIPMrpBy5R0N25Pj
         56d3ISUHIUp8dIWvpvUO9pQEqrmhtWeWhGryE6c6GM5rOp1ACl1hel7rKoZkGMFjczzF
         N8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897570; x=1737502370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPYIbHVE1it102on3lTKA/uIDG+wS+cqUn+a2PGr4p4=;
        b=IXpnXBfakFYQQrfaWsCqLPIQ4a6pKtDG7pNOrYk83XyZxOW0nX8rgDMYjsQZsP39ji
         9B/dFHckbuMgrJL3j/h5wGA/sKxIjFJQmta3Pq4gnYMJvpioStACq+bt5ibXUKcka25y
         KB9BV5wd45fyISj28AxEMjvXPjen/gYZfzOP45daHLDFPfMwIPjqf80lHlc2FGNF3F3Z
         e+IUANZLKRwo0ycplveOFDq4m2Ow+xrcAoeCGRefdTw9RzQMY+hyAenVChsVEttZ+Bq1
         Rz3ui5cGA0xfpEjHiABbSw0UFtYYokRwgEyyf0qF4xXIgfmxt0sClNISZ52VB9bRvc8M
         eZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcLAmsD2WSeCQqnbrGTEqmu5kwEHcdHLrC/KJczB9SOFpdDpusobiIPKuZh/Ddk4xDIqkhWaPVHl3fzn9N@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aOY9pnj3dmmlxtoXe/KZPpn/MbOBke2t2ahP3Mz2ogZR7e7d
	ZrQ2BuQqivB/T5Yorjceq4h8KHcGGdDIeeSbVegMyy6RdBp82ZGlDz8BC/1/f/4=
X-Gm-Gg: ASbGncsTfl2LzUnQbKQU5v4GLAxf8ks2fCNn4L8OF+UWIMRKRZJeLFcC8nK7YU6oUvI
	nB8KuXp25wBh41r10G20vxPMWC138e2PXmJQSwg/d5bpDMFVOs+3gl1wMQJ+y2BApelhIPeXk5j
	G6AFcOlAYfIxOCxNt90Hf+OIEjBnNAXYYBIzQ2jxbHVo1KXotsUhXYReFKJzZw/m15f9emzN7nh
	7QvndWZEJqHwG9gRCUJHRQT3lm0FqlFqKPPoW94NDnvH0+ZNlKHuayJscuf1HbYhRUSmIpluc2+
	6o9CMSoaOhRCwXkyfb67ig==
X-Google-Smtp-Source: AGHT+IEeG1jpueZQKj48HDOCPZVqrDJXvdVPxFGMLEPy6dXGa9TZnVPJnyPtfMQiw0IPOU1K9JiA7A==
X-Received: by 2002:a17:902:d4cf:b0:216:3466:7414 with SMTP id d9443c01a7336-21a83fcaafdmr420150135ad.44.1736897570399;
        Tue, 14 Jan 2025 15:32:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07cce2sm8846186a12.4.2025.01.14.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:32:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXqOt-00000005wyS-21zj;
	Wed, 15 Jan 2025 10:32:47 +1100
Date: Wed, 15 Jan 2025 10:32:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <Z4b0H5hQv0ocD75j@dread.disaster.area>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>

On Tue, Jan 14, 2025 at 04:44:55PM -0500, Chuck Lever wrote:
> On 1/14/25 4:10 PM, Pali Rohár wrote:
> > > My thought was to have a consistent API to access these attributes, and
> > > let the filesystem implementers decide how they want to store them. The
> > > Linux implementation of ntfs, for example, probably wants to store these
> > > on disk in a way that is compatible with the Windows implementation of
> > > NTFS.
> > > 
> > > A common API would mean that consumers (like NFSD) wouldn't have to know
> > > those details.
> > > 
> > > 
> > > -- 
> > > Chuck Lever
> > 
> > So, what about introducing new xattrs for every attribute with this pattern?
> > 
> > system.attr.readonly
> > system.attr.hidden
> > system.attr.system
> > system.attr.archive
> > system.attr.temporary
> > system.attr.offline
> > system.attr.not_content_indexed

"attr" is a poor choice for an attribute class (yes, naming is
hard...). It's a windows file attribute class, the name should
reflect that.

However, my main problem with this approach is that it will be
pretty nasty in terms of performance regressions. xattr lookup is
*much* more expensive than reading a field out of the inode itself.

If you want an example of the cost of how a single xattr per file
can affect the performance of CIFS servers, go run dbench (a CIFS
workload simulator) with and without xattrs. The difference in
performance storing a single xattr per file is pretty stark, and it
only gets worse as we add more xattrs. i.e. xattrs like this will
have significant performance implications for all file create,
lookup/stat and unlink operations.

IOWs, If this information is going to be stored as an xattr, it
needs to be a single xattr with a well defined bit field as it's
value (i.e. one bit per attribute). The VFS inode can then cache
that bitfield with minimal addition overhead during the first
lookup/creation/modification for the purpose of fast, low overhead,
statx() operation.

> Yes, all of them could be stored as xattrs for file systems that do
> not already support these attributes.
> 
> But I think we don't want to expose them directly to users, however.
> Some file systems, like NTFS, might want to store these on-disk in a way
> that is compatible with Windows.
> 
> So I think we want to create statx APIs for consumers like user space
> and knfsd, who do not care to know the specifics of how this information
> is stored by each file system.
> 
> The xattrs would be for file systems that do not already have a way to
> represent this information in their on-disk format.

Even the filesystems that store this information natively should
support the xattr interface - they just return the native
information in the xattr format, and then every application has a
common way to change these attributes. (i.e. change the xattr to
modify the attributes, statx to efficiently sample them.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

