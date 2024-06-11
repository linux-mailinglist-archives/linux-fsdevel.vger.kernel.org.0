Return-Path: <linux-fsdevel+bounces-21484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA79047B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFED91C21AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77D156230;
	Tue, 11 Jun 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S6fu1IWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8E4594C;
	Tue, 11 Jun 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149107; cv=none; b=j6JgNizwubGZHBbuej+3rC3iQy7TCpibVOARTGu88zjqUg7q4HKh+IEaMOQAgbsgJuSj+8YuS0+N69yRapBSpEKsA1TM/NyjboBlALU2BfmjKV+NmmMsiaNvYcQIbDFWVBsTPFR4ZPoSFttK1YUQ/47qf3UPB/FZlPKo/OI2uRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149107; c=relaxed/simple;
	bh=fLIw24HJGh25IvxM+XVgnFm1s7p+2mdeqRmB3vYlN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6SiLygSob1YleMWfo2puGBqiDODzeMgxsRJSEXRIfl0BFYuFu7wZtD6iJafE0QIQYYteY/RFSS1LgzftwCuJrtDUVta3X/dQxPEvAS4z7Rj3sBP6m0Q95LKFaUVE8BsN2shpld2jAW2uuJj1mgsr4u7w87hadw9C0e/Uz0ofN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S6fu1IWx; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mjguzik@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718149103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KY2/VQG4owvY7Tp0oU+yKzTr3CNrr/ih01w997Fyym8=;
	b=S6fu1IWxdgm9qLsmX6hCQ2Dn/Lg2Ih+LhSmXak8yH4owxrAfBrtuxoRNQGSgU6MOC6NEdl
	oCGdB4cMp3wQZKRZb1cWLPjDiI0uDEcyhmmXlIanVhMkEUwbyHzShCeFgTTNIlLANfvZHD
	CKnwvJ1s9Hvz/+PRVGMyWiy0iygAiSE=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-xfs@vger.kernel.org
X-Envelope-To: david@fromorbit.com
Date: Tue, 11 Jun 2024 19:38:18 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 4/4] bcachefs: remove now spurious i_state
 initialization
Message-ID: <q3g7lzfznnbsyqfstyniybpsrgzflwwj5eqdnu6pnyi4nmdcyc@l24omqkytmkc>
References: <20240611120626.513952-1-mjguzik@gmail.com>
 <20240611120626.513952-5-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611120626.513952-5-mjguzik@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 02:06:26PM GMT, Mateusz Guzik wrote:
> inode_init_always started setting the field to 0.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

