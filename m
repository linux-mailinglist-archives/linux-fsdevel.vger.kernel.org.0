Return-Path: <linux-fsdevel+bounces-38475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A4A03030
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D318822C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D41DF721;
	Mon,  6 Jan 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jirs+SRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A74503C;
	Mon,  6 Jan 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190587; cv=none; b=ikmle5aGVXKfjhUTharVXbB4eNURBITSLxNIA71vjAmCvuK+u4tZVXE9HnCw9APcM8Tg4UxB+1UNs3t+8GCKUrxedZ4WppFcuctCYSyH16rCVhQ0rv9B/yhyk7ZLRUq0zBXKNOhf30sCU6M0tf2va+TYr2gJ0NiTBIPCKkr4wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190587; c=relaxed/simple;
	bh=Ac6QYRlmb9odD6NHY62q27F44hcFEpQkjnzmvs9F9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEC/OZ4qjqulTiDekHVb/wwETtKDlnwZPvlrqOse+keJN+qOpj0wl3JK7M9RkdNMH7YCG7SxsmTu1jk2W6Ho+f2ecQpaimVx/tqyE3hR+kueDJPPzmvMS88f5c6QspWd+ONvWLF0SB8aXCJ2gKqCIuoDEE6bw+AeT+wLt8z3534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jirs+SRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51A2C4CED6;
	Mon,  6 Jan 2025 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736190587;
	bh=Ac6QYRlmb9odD6NHY62q27F44hcFEpQkjnzmvs9F9tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jirs+SRi/cJIb3qGkSZSnzGhhQmbHrr/Wn/y6i5J702srWWCZtCNxdfCmJkW4E8zb
	 vJSWGOR1rcgSmpt5Q2+JJ06O5LPM1bUmIcPG/GDsUa94w01TnBuU/vS2jKC5hhJZHY
	 AYj2zD/fnKgcIJeVmgq39AiHLvbSOO6D4TVfdfm9exvSIrS0KKw4Z59bHWzJlEdvtS
	 MJOprwSuqjV9trVk2AshKA8eKEWHpadwFyDKCAOqVlg0SvE/5tsW1n2DHv3X99njpv
	 ah42n70asx67ZtIR1scW9kSHRcHAC0lAOut5sZGVcFIPo0j3Ye3gnnL8FIH5hkLBp0
	 jLymLLxAb/Y3A==
Date: Mon, 6 Jan 2025 11:09:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <20250106190946.GF6174@frogsfrogsfrogs>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151938.GA27324@lst.de>
 <20250106174007.GD6174@frogsfrogsfrogs>
 <20250106180958.GA31325@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106180958.GA31325@lst.de>

On Mon, Jan 06, 2025 at 07:09:58PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 09:40:07AM -0800, Darrick J. Wong wrote:
> > > +stx_dio_offset_align
> > > +which must be provided by the file system.
> > 
> > I can't imagine a filesystem where dio_read_offset > dio_offset makes
> > sense, but why do we need to put that in the manpage?
> 
> Well, to be backwards compatible to older userspace the value put into
> stx_dio_offset_align also needs to work for reads.  Given that there
> were questions about this in the RFC round I thought I'd mention it.

Ah ok then. :)

With the other formatting nits fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


