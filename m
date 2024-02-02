Return-Path: <linux-fsdevel+bounces-10038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E8C8473CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D957F1F23D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17719146919;
	Fri,  2 Feb 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FVvONehL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59B1474A0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889434; cv=none; b=URAk3tzrM8gHEvnpyAGMlcfItjj58mY+ku6HQjIzQrfshW9OIoVvFrKe6gGIq3twStM6ClInV9uhkvnyR077CAKamj7jENculK9S6gDu12Xv7MNR+GwJhfjOu14Ck0y/ITUiVI4LpuMbd5SXY0VKXMl4T91APXEK/jX5G+c0yx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889434; c=relaxed/simple;
	bh=2jikjFg1dSD1tBPtvM9G1L0yaZBuBjSlS3mgUgsOjag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWE+Vk1nrrCjGxHHF87Xv4DtMb5GonBU8Gd1cUqM/o3HxsFukwArngBc7TfA3dpdma8oEBdDfkQbTS/RPe2Ke34CiaHlbPAwSq+9WtWp1DpUz7D+Bkv7G+6PICFM38S8d0MM813MtH2hZPchRk1Kmfm55/EckzS41gyqpWjo2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FVvONehL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 412FukRJ018190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706889409; bh=S1s9YAh0b/lwR8J2VsxuU6eumJObqbXVV9D2xlEfB+s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=FVvONehLiWR1DkFmj2nD5MJcNeNCdDNAcgvhKU2EULJ3zg8ODZpD7cnlfvDY7EilX
	 OmF/JU2BJdHIRDZ4NImdVBhxNIP6qhlJPNnDVKRRHFpBv66KQWRPhkAIT1VOlJqlOf
	 4LKHBgQC743mbg8lkKE7tNTgUxxQh1Lii1vseVSMRFHK/2KQJ3NfSk8dbht2/rJSKT
	 jejo6PfRG57vDgNrz9JrqxeRz1MpBsdZ/GOiptqVasS0EMjWHLC7owTyh3fQVZ9W/4
	 aAXc2nSbay60uHrRuleD6S3Q1HiBJBbxO3xzw/Q+0Q3aOYbgZwUeDiDCaOJETeU1NI
	 WsZdBtvYzvh+w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C988015C02FC; Fri,  2 Feb 2024 10:56:46 -0500 (EST)
Date: Fri, 2 Feb 2024 10:56:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
        amir73il@gmail.com, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] ext4: Configure dentry operations at
 dentry-creation time
Message-ID: <20240202155646.GB119530@mit.edu>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-10-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-10-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:27PM -0300, Gabriel Krisman Bertazi wrote:
> This was already the case for case-insensitive before commit
> bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops"), but it
> was changed to set at lookup-time to facilitate the integration with
> fscrypt.  But it's a problem because dentries that don't get created
> through ->lookup() won't have any visibility of the operations.
> 
> Since fscrypt now also supports configuring dentry operations at
> creation-time, do it for any encrypted and/or casefold volume,
> simplifying the implementation across these features.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>

