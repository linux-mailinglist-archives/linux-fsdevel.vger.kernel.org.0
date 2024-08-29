Return-Path: <linux-fsdevel+bounces-27857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A797964821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27F01F24042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072771AE850;
	Thu, 29 Aug 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1HXzkMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D321AE84C;
	Thu, 29 Aug 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941340; cv=none; b=UVCs4J85CVzSv/Ry8KYT5MmPPAgVOH98ULGjKWcAutqYSqqzm/fhg8Vy77nrOLioeKzkf72J26aYmTqEb6prvN+Q0GHz/r3UEVeBVrTIfUNSolPMSGeFZuxg2SN1KIXDo9unukeO3eDMpQlJkg3ZrEp/NwAnY4Ljzs91Tt8tKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941340; c=relaxed/simple;
	bh=zhe0yccw+b501igd2bzezjYfBJp+IyhkKqlh+Evg3Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNJJfWNFDTuxZ7TssgZgyhvGeHfuWrOvfvvYUCxP/DsirjZYjUB6m/zbRNhlsdh/x4vkyKpFa6ErfmLhHcw0m2ljggw1A6XFfOHPX3zcuZF5llQNBsoWZ+e03RWC5bewMIgrrP6mbfj7NOaWHzs+RMBtiqUYb4bKhnDnUmcY6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1HXzkMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF3C4CEC3;
	Thu, 29 Aug 2024 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724941339;
	bh=zhe0yccw+b501igd2bzezjYfBJp+IyhkKqlh+Evg3Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1HXzkMtqUc2x61Kr2HKWhnTO0F/UdddBEEitb5MQDfiy7nP0TMkb+6ZCvD9sR6WD
	 CWotydeMFcLALf3PrLWQf9gJMeKKFVrAtSOOqnEBz75kFY9dZsEJvnmOBO3UPQUCPV
	 yy7yR7EAnkH0FkJpIzZb2h5cWtXDY96DDU+n7O2M3aKqlxcIhQnK88OA1QMUwfpiEo
	 IcUjXv55ES93zVFN2j5b1Qj/EnGy8rhcvGCg+nte82XrKUwINJZ1hwPu2kPXNLq1GL
	 sWc/2YctUejbc+ntw9fGFLLJT5be766tnNyik/chg7xqg5VDzKiqIAUmJ3sR58K9Mw
	 N5OnFtFnOaMBQ==
Date: Thu, 29 Aug 2024 07:22:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race in
 iomap_write_delalloc_release
Message-ID: <20240829142219.GC6216@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-2-hch@lst.de>
 <20240827161416.GV865349@frogsfrogsfrogs>
 <20240828044848.GA31463@lst.de>
 <20240828161338.GH1977952@frogsfrogsfrogs>
 <20240829034626.GB3854@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829034626.GB3854@lst.de>

On Thu, Aug 29, 2024 at 05:46:26AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 28, 2024 at 09:13:38AM -0700, Darrick J. Wong wrote:
> > Though we might have to revisit this for filesystems that don't take
> > i_rwsem exclusively when writing -- is that a problem?  I guess if you
> > had two threads both writing and punching the pagecache they could get
> > into trouble, but that might be a case of "if it hurts don't do that".
> 
> No i_rwsem for buffered writes?  You can't really do that without hell
> breaking lose.  At least not without another exclusive lock.

Well, i_rwsem in shared mode.  ISTR ext4 does inode_lock_shared and
serializes on the folio lock, at least for non extending writes.

--D

