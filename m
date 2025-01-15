Return-Path: <linux-fsdevel+bounces-39213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A7A115FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F63A7F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DE1CA9C;
	Wed, 15 Jan 2025 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCnbpubh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B717BD9;
	Wed, 15 Jan 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900185; cv=none; b=qTpDbr712jZXh1yruhPKmMNOa+C3rGJ4CmG43/zlQR4RgWYcriM92/0VK3623LVm4g9sGw5kh9ilnnqw7+IaCc6h+cD8AXw0++fsucZuYX2qe6C2Iqr1kVBLkxOrG48/AAyeZ5dRWZpCzNDFUZA4W0CLRuFzMPE35dyIZthRIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900185; c=relaxed/simple;
	bh=zkHbdaIRWk4r9Ce9VNgwbPkA5SUxExy1sLasqNms8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P99lz9ICZ5mKEhOGmG9nss08Lbe4qktfF6uwIuawslbBIytq40FWFR93oMrfAtWkX5FiFm9t7xGPjjmPMnBlvrvEK5o5AGKAKf+yw+nxXXzRSUCJ4C+1QZZJV61etbUO1vO/UE7+33yjD6N/lGh+udnFwxGb/hL8sV9N8kp6Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCnbpubh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA76C4CEDD;
	Wed, 15 Jan 2025 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736900185;
	bh=zkHbdaIRWk4r9Ce9VNgwbPkA5SUxExy1sLasqNms8wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCnbpubhNi8Jwto80jejGJmzEc+nKwcBO2YZJt73SJDI1CFwspoOQeN5honhpkspH
	 bsKlypIFTUVgzRTdiAnlH6Dda/cgytAaV5+s7FL1HkKmAyqn4ucCUAHuh7tYeCcnQz
	 fj7Cte4BdMVJFxYRRq23Dq7+RdTsxO80/wZxFTB5WFegsUoiR1sj0IVylhey4qQmMR
	 SmESFSbpo4yJv5vFU4JPFQtlUivhF+5VPv+Nc7lCCoHoNBG9k+1BSvLeyQuiFGjR0K
	 hS7TcH8FrFCskKnILOuWRR0aEhdz/MpqgwsF7e1LvbXke1bFnfn6U53pL3X4OUEc8m
	 pSR1XCo1CNyeA==
Received: by pali.im (Postfix)
	id 4BF9D4B4; Wed, 15 Jan 2025 01:16:14 +0100 (CET)
Date: Wed, 15 Jan 2025 01:16:14 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250115001614.jsshx375x7k5ylaw@pali>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <Z4b0H5hQv0ocD75j@dread.disaster.area>
 <CAN05THT8oP4q90wqxSN3vR+EYEPXfe1Ts=rqVYg6mthUXytWbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN05THT8oP4q90wqxSN3vR+EYEPXfe1Ts=rqVYg6mthUXytWbA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 15 January 2025 09:42:26 ronnie sahlberg wrote:
> On Wed, 15 Jan 2025 at 09:32, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 04:44:55PM -0500, Chuck Lever wrote:
> > > On 1/14/25 4:10 PM, Pali Rohár wrote:
> > > > > My thought was to have a consistent API to access these attributes, and
> > > > > let the filesystem implementers decide how they want to store them. The
> > > > > Linux implementation of ntfs, for example, probably wants to store these
> > > > > on disk in a way that is compatible with the Windows implementation of
> > > > > NTFS.
> > > > >
> > > > > A common API would mean that consumers (like NFSD) wouldn't have to know
> > > > > those details.
> > > > >
> > > > >
> > > > > --
> > > > > Chuck Lever
> > > >
> > > > So, what about introducing new xattrs for every attribute with this pattern?
> > > >
> > > > system.attr.readonly
> > > > system.attr.hidden
> > > > system.attr.system
> > > > system.attr.archive
> > > > system.attr.temporary
> > > > system.attr.offline
> > > > system.attr.not_content_indexed
> >
> > "attr" is a poor choice for an attribute class (yes, naming is
> > hard...). It's a windows file attribute class, the name should
> > reflect that.

Sure. This was just to show how pattern can look like. Does not have to
be the final name. I agree that naming is hard, but in this case I think
the harder part would be to design API.

Btw, first 4 attributes were inherited from dos, so they are not
originally from windows. But that is not important and it is better to
have consistent naming.

> > However, my main problem with this approach is that it will be
> > pretty nasty in terms of performance regressions. xattr lookup is
> > *much* more expensive than reading a field out of the inode itself.
> >
> > If you want an example of the cost of how a single xattr per file
> > can affect the performance of CIFS servers, go run dbench (a CIFS
> > workload simulator) with and without xattrs. The difference in
> > performance storing a single xattr per file is pretty stark, and it
> > only gets worse as we add more xattrs. i.e. xattrs like this will
> > have significant performance implications for all file create,
> > lookup/stat and unlink operations.
> >
> > IOWs, If this information is going to be stored as an xattr, it
> > needs to be a single xattr with a well defined bit field as it's
> > value (i.e. one bit per attribute). The VFS inode can then cache
> > that bitfield with minimal addition overhead during the first
> > lookup/creation/modification for the purpose of fast, low overhead,
> > statx() operation.
> 
> For this use case I don't think he means to store them on the cifs
> server as xattr
> (or case-insensitive extended attributes as cifs does).
> They can already be read/written using SMB2 GetInfo/SetInfo commands.
> 
> What I think he means is to read these attributes using SMB2 GetInfo
> but then present this to the application via a synthetic xattr.
> Application reads a magic xattr and then the driver just makes it up based on
> other information it has. (cifs does this for other things already afaik)
> 
> Correct me if I am wrong Pali, but you mean translate the SMB2 attribute field
> into a magic xattr?  But that means it is not storage of the
> attributes anymore but rather
> the API for applications to read these attributes.

Exactly, thank you for better explanation. If filesystem supports
"hidden" attribute then request from userspace call (setxattr
system.attr.hidden) would be translated to filesystem native "hidden"
attribute. Which for SMB2+ is SetInfo(), for NFS4 is op_setattr(hidden),
for FAT/exFAT/NTFS is updating hidden bit in attrbit field, for UDF is
updating hidden bit in FileCharacteristics. And for other filesystem
which supports "hidden" attribute natively, it would be stored as that
xattr system.attr.hidden as is.

Performance for sure needs to checked. I have already wrote it that it
could be a problem for userspace applications when they would need to
call lot of syscall to just list directory entries with all attributes.
So for getting attributes maybe some statx() interface could be useful.
In my opinion, applications would probably ask for attributes more times
than trying to set or change them. It is like stat() which is used more
times than utimes() (or other syscalls for changing stat stuff).

In any case, Linux SMB client is already fetching all those attributes
because basically SMB protocol always sends them. So SMB communication
between client and server should not be affected at all by any solution
which is going to be chosen.

> >
> > > Yes, all of them could be stored as xattrs for file systems that do
> > > not already support these attributes.
> > >
> > > But I think we don't want to expose them directly to users, however.
> > > Some file systems, like NTFS, might want to store these on-disk in a way
> > > that is compatible with Windows.
> > >
> > > So I think we want to create statx APIs for consumers like user space
> > > and knfsd, who do not care to know the specifics of how this information
> > > is stored by each file system.
> > >
> > > The xattrs would be for file systems that do not already have a way to
> > > represent this information in their on-disk format.
> >
> > Even the filesystems that store this information natively should
> > support the xattr interface - they just return the native
> > information in the xattr format, and then every application has a
> > common way to change these attributes. (i.e. change the xattr to
> > modify the attributes, statx to efficiently sample them.
> >
> > -Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> >

