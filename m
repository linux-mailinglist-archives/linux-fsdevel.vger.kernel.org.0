Return-Path: <linux-fsdevel+bounces-73940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B593D25D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32BD3300C343
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129C3BF2EB;
	Thu, 15 Jan 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XDziS0Z6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0E3BF2EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495538; cv=none; b=tSvBd6JOa+0pIIG/GkZZG1Fh21223Sx6IK0hh5cJbO1Qv84sUtJv9JgeYc17VXXVIn3DXV/TPhU0sdDs+7S2inHwpx8Ey3Wi6M26zrTCa73iZI98vr2aLLI0WqpiIvOYfifXFToVKE2oKnCyu4AHioLsocFD8mw75D6XNmfc2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495538; c=relaxed/simple;
	bh=2HCmH5r8cl1tEDSLFBelNClzMABzMx70/iUher6kjok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcmItD3FPRdoIfFYMAbUpYXGMvT6jWqU25TPnSxLyIy9KkHR+wyVknQb42O8+Vz0T/8UGZBlE93a97tDZgXT33GXOtVvZsp2eGFyJ8+htf/dL5SziB/jVo14qg6WxY9c7xKSQW3gmXDcyeZ8AxSgDL30nYRfJkTZijSnvHKcL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XDziS0Z6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([37.140.223.84])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60FGjBda015346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 11:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768495516; bh=h5p4xDv48spuLP8tOq8jDpufYPNxaKi3ct01jIsuNmY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XDziS0Z68J3RmCV+61gyKCx0PtMCi2SAErasQZiD/W3OYv18oUyIEd0XULXSSLx/U
	 4ZJEBqGtHDSN0/j63Ey0PsAIDc3lLOut9fBF8vOPkaC4P4bWosJySAs7MwXsqsSrXW
	 AhDiOqyFPtMyAgIEy1P+DyDpkTBcag5eKyGkvObenZrIBNqr4ojAyALE5+3JzkfXgI
	 +1iqiMCf+WpNNPHoQ2cU+jLXYbGzKgmbIYDebZLDLH2uVrutlpniKHrUMQiRSHnV0z
	 dg1bC8awLacyy2Z0EfBJ+Qa/ikA8YpYE6ZjWOYD7OLiipYqYkF4OdbFBVDSanZf2io
	 tTXyUqAoxf1Aw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B4C4554CC0A3; Thu, 15 Jan 2026 06:29:38 -0900 (AKST)
Date: Thu, 15 Jan 2026 06:29:38 -0900
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
Message-ID: <20260115152938.GD19200@macsyma.local>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
 <176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>

On Mon, Jan 12, 2026 at 04:32:27PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Use the new fserror functions to report metadata errors to fsnotify.
> Note that ext4 inconsistently passes around negative and positive error
> numbers all over the codebase, so we force them all to negative for
> consistency in what we report to fserror, and fserror ensures that only
> positive error numbers are passed to fanotify, per the fanotify(7)
> manpage.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Theodore Ts'o <tytso@mit.edu>

