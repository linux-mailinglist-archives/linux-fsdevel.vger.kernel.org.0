Return-Path: <linux-fsdevel+bounces-59932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17463B3F4AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEA44845B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C12E1EE1;
	Tue,  2 Sep 2025 05:41:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E482DF15F;
	Tue,  2 Sep 2025 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791693; cv=none; b=l3HP8rxxVHua5CelopPH8/Z/+NQxn7XXeZKpDgTbJ72TsNBjMwNaIYA1T6nJtTCKphfYFFqinjj+ADsdHM2R0QGNDc2WSz+BudSgxXP9gnVZsZ9dO7YWf9fkvyPPeORdN3mne0AruTmmzU0vmRojv4CBpKad9RrnG9k3+23m9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791693; c=relaxed/simple;
	bh=FCPItX51ftfJwNd9LKPXKDxLEcxlIj4CbHGkRRyvF3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHiI9Ca0IrtJR/RY5IfZMS1cUEKM1onqnS6ibtYPvgmdPw+5QX0AQzkIneT1SDfdz+nspOl0OYDjHSPqjUPWkFIcxG4ylY35t7BFgsnRWXRSeP0xYHFayP7BhXJIezNFFrwWyC//ApluVph5Vgtkck4mntqF9Mv7SIO1N2ls9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AE2368AFE; Tue,  2 Sep 2025 07:41:28 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:41:27 +0200
From: hch <hch@lst.de>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] xfs: refactor hint based zone allocation
Message-ID: <20250902054127.GB11431@lst.de>
References: <20250901105128.14987-1-hans.holmberg@wdc.com> <20250901105128.14987-3-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901105128.14987-3-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 01, 2025 at 10:52:05AM +0000, Hans Holmberg wrote:
> Replace the co-location code with a matrix that makes it more clear
> on how the decisions are made.
> 
> The matrix contains scores for zone/file hint combinations. A "GOOD"
> score for an open zone will result in immediate co-location while "OK"
> combinations will only be picked if we cannot open a new zone.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


