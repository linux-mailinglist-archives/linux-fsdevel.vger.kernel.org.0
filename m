Return-Path: <linux-fsdevel+bounces-12156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CC85BD38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0A2865FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615A6A342;
	Tue, 20 Feb 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJsUQi5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C069E05;
	Tue, 20 Feb 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435924; cv=none; b=eHszwRqhqKzTLrbA1a7GIUuHOdo1uY5HtPTs06Hqs0BWje54iUNT7ez3fdhKAnYij4wdNYr3ygR5XQOYhQu9jeOde9fNZtjD2exWejdFFsfOGvIKmTjYayfWYlwJ5N+yiwFq6UIYm9Sx24Gzs6czc/gt7FthaiKStJXtPfWLGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435924; c=relaxed/simple;
	bh=kSbCNkvZKv7xzsaEeoxDKEEwm8/5FhdatiejKc2BuLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/406Q+uawDsH3A5BmKl9aBbuHGcaAt70JqCpsUJNvHslu25JrEKV/6m+tfI+NIsZgJZAIy42KpxpDrTSWLSdFL5llwneZm58gsd5bKX6T9gRmXirD+HHadkQqOdMyl05HqOGvjy/tm4CH++wEn/KKomTw+xfA3wSMQdDrxYg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJsUQi5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E2C433C7;
	Tue, 20 Feb 2024 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708435923;
	bh=kSbCNkvZKv7xzsaEeoxDKEEwm8/5FhdatiejKc2BuLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJsUQi5KCSO8MtsgHZ+Vn/m7BcHINEuYM5ToUiaFq7kh2KQMRPea4IFD5yzNstNiD
	 1rIrxcgdE21DiDSY+Q2JJxcDATS0zp9n2BOMTPLWHFRlbsXLbHaaqN5dvJRaiDArc7
	 v/X9MUp8DeIQZnjEpz/WW9n9i2tUrPb1ZFwv+vbErFChi21tJp2tWkJtX7HBup9UZQ
	 IRBcqjs1VlPXekQrY3dUUtseVwFyj5b9J8dvDyM/KdT59kDx5Z9w6ypWLA4FsSESQH
	 3j7QwtZUDUGkVZR1WWGjNCetelLouTz+eg5OLO2Ij0xwNRIa3n6pZCBufJmoXudWHV
	 3xQ463OyS0adQ==
Date: Tue, 20 Feb 2024 13:31:58 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Message-ID: <20240220133158.GL40273@kernel.org>
References: <20240209105947.GF1516992@kernel.org>
 <20240205225726.3104808-1-dhowells@redhat.com>
 <20240205225726.3104808-10-dhowells@redhat.com>
 <140602.1708355444@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140602.1708355444@warthog.procyon.org.uk>

On Mon, Feb 19, 2024 at 03:10:44PM +0000, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > >  /* Functions related to files and directories */
> > > +extern const struct netfs_request_ops cifs_req_ops;
> > >  extern const struct file_operations cifs_file_ops;
> > >  extern const struct file_operations cifs_file_direct_ops; /* if directio mnt */
> > >  extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
> > 
> > Nit: this hunk would probably be better placed in the
> >      patch at adds cifs_req_ops to fs/smb/client/file.c
> 
> I'm not sure I understand what you mean.  Is there a bit missing between "at"
> and "adds" in that?

Sorry, "patch that adds".

What I meant is, the declaration of cifs_req_ops and it's definition
seem to appear in different patches of this series. And it might
make sense if they were both in the same patch. But given that
both are present by the end of the series it is more cosmetic
than anything else.


