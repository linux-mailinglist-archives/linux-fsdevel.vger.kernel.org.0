Return-Path: <linux-fsdevel+bounces-46877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F6A95C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA1816C990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AF1547C3;
	Tue, 22 Apr 2025 02:44:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC925634
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289868; cv=none; b=NygcD+BKR0UJ/JP4JQ0OSifFqI/6ZsHJEh6jdKLkogyl9l1AlgwjSKKICiCbmJdGf33CIFb3SFTxA4/vSvN2bjHurNPPJsQnLmX064ZF3W9+omdnWP7C7xrql7p/aME4KXL48IpyTYSdATRjn85m3FNj+h/AO2uUt4AAHyT4VuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289868; c=relaxed/simple;
	bh=91KfZCh9TIFmjYIfZqOtIrFUDdePVwuUW5h5/fqFh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxkSqHdUDoamC15Nuy7ikZXdKxuCN0xmbFvHQr9Kyx/zeM24QukpD6R6bHD2CtJu73bBSmOYLyPFjtvbbbePPiY53qoG7c7kTLQ0cvGwAHtCMj99eKxtxeT3AGQwwfIEJZydG0G3UoDqupw2Sqo1dkb2ApcoN4qoZy8bHC3F0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53M2iDst016284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 22:44:14 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 17A153463A6; Mon, 21 Apr 2025 21:43:33 -0500 (CDT)
Date: Mon, 21 Apr 2025 21:43:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: HFS/HFS+ maintainership action items
Message-ID: <20250422024333.GD569616@mit.edu>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>

On Mon, Apr 21, 2025 at 09:52:14PM +0000, Viacheslav Dubeyko wrote:
> Hi Adrian,
> 
> I am trying to elaborate the HFS/HFS+ maintainership action items:
> (1) We need to prepare a Linux kernel tree fork to collect patches.
> (2) I think it needs to prepare the list of current known issues (TODO list).
> (3) Let me prepare environment and start to run xfstests for HFS/HFS+ (to check

One potential problem is that the userspace utilities to format,
check, repair HFS/HFS+ utilities don't really exist.  There is the HFS
Utilities[1] which is packaged in Debian as hfsutils, but it only
supports HFS, not HFS+, and it can only format an HFS file system; it
doesn't have a fsck analog.  This is going to very limit the ability
to run xfstests for HFS or HFS+.

[1] https://www.mars.org/home/rob/proj/hfs/

						- Ted

