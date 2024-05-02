Return-Path: <linux-fsdevel+bounces-18505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DD8B9C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 16:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F04DB2146F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8C13C81F;
	Thu,  2 May 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8xTyZlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D613C811;
	Thu,  2 May 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659224; cv=none; b=ivQ6qguK1bhqtIgGBw+oUl49SRtCgweDHUdLm1tCtkkwoX+USkW1rdz1cOYWsskJ7obh2SNMCgzSCc3iTPRydcmx/ydTVg0Con7jwGLs8xo1qbKv3lDyJG5PAw/hmI2l32sWBdUSPMnJnm/LIY3lXC8jsfnSpARXWWXgxvJ8DXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659224; c=relaxed/simple;
	bh=1vUXQjL1XIYEiLePPiS1dnxjykzdCGKwKFECXqOOXzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfijr899So2gKGZhhOFuuXhuDaT+9Je6XSmudKlLU66jl6Sp+qoS5kVTO0d8gW1rO1WI9HoMBflVrvuFg57GuiH32442hiceyjYne54KMNv7L4WJSooLPHoUZynmg0bXsDEx6DhOoz7toUOOVNtYQ6ASMoV5ULoGIDUyvi4fDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8xTyZlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC64C113CC;
	Thu,  2 May 2024 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659224;
	bh=1vUXQjL1XIYEiLePPiS1dnxjykzdCGKwKFECXqOOXzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8xTyZlQzl3HNe7cUjrdAgZ1NKd380t0HFvkjEvsnV+7K5cONejVCpBir2khe4grt
	 IHE37n0odjwFWjz/dLJui5uXE5zfT9y8I1oyfmFlDdHY7oyIsrTw7Xb15EJyap380V
	 GMJManJexVkv5kFR40UDgRIsUVtRd40xVghp5dqGaG6CIYeXa1xt7Qzaj4zUSQ8FhV
	 JsgIQvMoLGc7x+BnQLcd8FPPXmn1PO4F7pMQnOljy2mhEAxQbdQLzvXyu1JGonVQwJ
	 8dTasmNqJ5lcRe9QZ9Ua3V/Ay4cBLszk1nRUPXCRxvO96/f+LYcCnJs0tbTM9EYqQR
	 2zqWufBT8RCPw==
Date: Thu, 2 May 2024 16:13:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, netfs@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/16] netfs, cifs: Delegate high-level I/O to netfslib
Message-ID: <20240502-beteuern-vollzeit-54b8237c2809@brauner>
References: <20240430140930.262762-1-dhowells@redhat.com>
 <264960.1714488463@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <264960.1714488463@warthog.procyon.org.uk>

On Tue, Apr 30, 2024 at 03:47:43PM +0100, David Howells wrote:
> Hi Christian,
> 
> With Steve's agreement, could you pick this set of patches up also?

Pulled both branches from you. Thank you!

