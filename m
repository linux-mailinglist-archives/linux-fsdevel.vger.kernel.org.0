Return-Path: <linux-fsdevel+bounces-19696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F98C8CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6B1C20F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D6140367;
	Fri, 17 May 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EclpJ7PQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071F60B9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974634; cv=none; b=Ojz4uPOK7wPBECipNQ9HGZTkgeS3necDUzNTvUobciZDygaw2vZF1DYWTTE/k8+I1Zpcp72OwI2xkPoh9D+WTmuMGrUgnX36pfDszkNnzFPawndKXNXB0pEm6IznCEgAeAZEgnBcBB6DqiefbuDIFfpPvBgYC+JQZN5uOhQc1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974634; c=relaxed/simple;
	bh=JAA8iSyx6bgiRG8Ddo2k0qxje0uyk0tV5RfZ/HiAvnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpAffXwXunOaolORqjcakYoZjEJ20veQnb9Tqun5X5aHBR7+OlrgCEfUglMo3nGqeXd4VBZ5RUnm1phr6OOsc8YVWuasgzlTyRnZkco4NnehTUd/TzrCdw7w3uk5yFBCVhbCcToPcQG6tWoLh+/gG3ntvOKn3Q11bQdnY1NfY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EclpJ7PQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44HJaevV011512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 15:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715974602; bh=art33/7wTYbQAOP1A+9aiHxSsPpImcDO5odsBbbfpUQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EclpJ7PQjaegxz8wu5lKouYqK1JbiU4EjkVr+hWch040PZby/TBfP1l1T7G9Ayisx
	 viipOADDd+813uFUK7KcegkdN8stsYl7MtSldKfeudFInaciKEVKGdeodtg8Dl2eGQ
	 U5DI2kA0ISW2iYIX8BcTV4JJyiwHIzhq3wwnkzfzDikMnzkYLG/nnGNB9Q7mpdOP+B
	 Km6IBJZ4PE/yx4kiExEQvBJmpXoi6fDy8Ad8ZbpRaJ02w/KItoBMxUTNqbv1ZCQlLs
	 WVqJ2wQXUbyUFS6GFJ2NXVhFVcLQ7T5AvLfEe3YwTWEimpYgP1e6lkN3gXgjeblySd
	 w/NjYcktGc0fw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D12E415C00DC; Fri, 17 May 2024 15:36:39 -0400 (EDT)
Date: Fri, 17 May 2024 15:36:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
        aalbersh@redhat.com, linux-xfs@vger.kernel.org, alexl@redhat.com,
        walters@verbum.org, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240517193639.GA65648@mit.edu>
References: <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
 <20240509144542.GJ360919@frogsfrogsfrogs>
 <Zjzmho9jm2wisUPj@infradead.org>
 <20240509150955.GL360919@frogsfrogsfrogs>
 <ZjzoLKev1WqnsBx-@infradead.org>
 <20240509154323.GM360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509154323.GM360919@frogsfrogsfrogs>

On Thu, May 09, 2024 at 08:43:23AM -0700, Darrick J. Wong wrote:
> > Well, fsverity as-is is intended for use cases where you care about
> > integrity of the file.  For that disabling it really doesn't make
> > sense.  If we have other use cases we can probably add a variant
> > of fsverity that clearly deals with non-integrity checksums.
> > Although just disabling them if they mismatch still feels like a
> > somewhat odd usage model.
> 
> Yeah, it definitely exists in the same weird grey area of turning off
> metadata checksum validation to extract as many files from a busted fs
> as can be done.

I've certainly thought about the possibilities of adding a CRC
checksum type.  We do need to explicitly mark this as a
non-cryptographic checksum since it might have make a difference for
IMA policies, etc.  This would be useful for detecting problems for
people's video or music archives, for example.

I can imagine situations where it might make sense to allow the file
owner to be able to disable fsverity, whether the checksum and use
case involves cryptographic or non-cryptographic checksums.  Having a
flag in the fsverity header indicating whether dropping fsverity
protection requires elevated privileged or can be done by the file
owner seems to make sense to me.

      	       	    	     - Ted

