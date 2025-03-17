Return-Path: <linux-fsdevel+bounces-44165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EFA640F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D2918910FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95052219A9E;
	Mon, 17 Mar 2025 06:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A64215047;
	Mon, 17 Mar 2025 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191884; cv=none; b=k2nITzd9xssBE7GQZLpb7FTYe6AeEQcUUO2pkTqDKIg9hG2JKmJl2pN18WiyLJoBeTCmWxUxRZWuSaC99lrug2Tt5vQ0e3qaLMXcSIbZCnF2Tblg6jBGcrpp4MyBgEhiE/z1dzef+oXlBhEcsa93ltNF47chyXgik2ybl4C0eF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191884; c=relaxed/simple;
	bh=/nB4rgPllvzrAXNI3w7U5k2NdL6thbbn/joYZo8xB4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8Lo9O+9Hrd3dfY4bzL85PpkZlCB/DQj2AW9f+BCXBmq6Vttk2Ll9V8AMpZo5ApcdPZXroOvXedFXSkrERPdfQ6V540fNBQ3KTM76poGmBeKH/T4f8egCNbZ+FH9QZKbk45vwRbMrBrySrLPLMn1ZuXoDVfVaw94nM95cyqAfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7722068D0A; Mon, 17 Mar 2025 07:11:16 +0100 (CET)
Date: Mon, 17 Mar 2025 07:11:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
Message-ID: <20250317061116.GC27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-4-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  		iomap->flags |= IOMAP_F_NEW;
>  
> +	if (flags & IOMAP_ATOMIC)
> +		iomap->flags |= IOMAP_F_ATOMIC_BIO;
> +

Add a comment here that ext4 is always using hardware atomics?

> +	if (flags & IOMAP_ATOMIC)
> +		iomap_flags |= IOMAP_F_ATOMIC_BIO;

Same here (at least for now until it is changed later).

> + * IOMAP_F_ATOMIC_BIO indicates that (write) I/O needs to be issued as an
> + * atomic bio, i.e. set REQ_ATOMIC.

s/needs to/will be/ ?


