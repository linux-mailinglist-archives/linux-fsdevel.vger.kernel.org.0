Return-Path: <linux-fsdevel+bounces-68106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1FC545A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 677BA34B829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4C728314E;
	Wed, 12 Nov 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ggZzRfk1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C687280329
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977975; cv=none; b=dOGFDzgUhhg1Q0e1hZBNRaZrbeL7/HPBdmXVA1RGaR7848vgkY4pTPTn1T6VhJ/rpELhgi1p+D8tcs+3M7dEBx7LLqOjgWlEyNt5O9UIo+9lrvX9APLd6DDXN6oe2NO4BzhzE4NVnPLsVar+2F+nrObgh77y75mM0A31uE1mzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977975; c=relaxed/simple;
	bh=YidZ2iaBMgBfIyOZoPUl0ZumXjccVvctwYCN9vaa7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smSsiIyRBauwetZjYIirB3ELg1CI0ApYk4GJ6T+wm9/61YqpAQxWXYsBY6VxlaQG1ETCMbwwtH9XCvgEjsUIkfBAaR7l8SXSvm6gbm4B8IySTpNIga7pwOfnw//dJfl6CtBCQvad+BrAMtZRPEbNZhN+i0X+sacUTAxroG+aj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ggZzRfk1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ACK5eQT024470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762977943; bh=C28Oa7WcfAdQg4Gfs4Lt81ztqf7ENvQBvIcZtxopAbw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ggZzRfk1rAV++4yYImW8ycBzitiVkxYScyVjgkr5RbWEXzVVwiy5jI/JeBrpq5v7s
	 ijf3n5lf5KpnNkFU2GfUEqnfeS8vgux1MRK2RSsroEHb4oCQdM7709GwqdfOD4z/1+
	 vIwuW+gC4ATR1ql9BIh6/m2hW15LjRYLdBwWGb3L/kr7JFqFBrhtoCZtVm2uguPY/N
	 ztQ4C1PRDixs3VXH11iQVp801Ah8njnleXs8NpxlAiD9INrj4N3InXtyoIc6kDPCk1
	 v6xwbVYETd4LGvGx8Sym/eLk4JQtPis0oja7pf+Y6gwh/zDe8lBCgOVjDy60AU/RSK
	 hN9XGsQzoZ46A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D487D2E00D9; Wed, 12 Nov 2025 15:05:40 -0500 (EST)
Date: Wed, 12 Nov 2025 15:05:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, zlang@redhat.com, neal@gompa.dev,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
        bernd@bsbernd.com
Subject: Re: [PATCH 04/33] common/rc: skip test if swapon doesn't work
Message-ID: <20251112200540.GD3131573@mit.edu>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
 <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
 <20251112182617.GH196366@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182617.GH196366@frogsfrogsfrogs>

On Wed, Nov 12, 2025 at 10:26:17AM -0800, Darrick J. Wong wrote:
> 
> Well at that point we might as well collapse everything into:
> 
> 	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> 		_scratch_unmount
> 		_notrun "swapfiles are not supported for $FSTYP"
> 	fi

Agreed.  I don't think the ext4 special case makes sense here.  If we
want to have a specific "swapfiles are working when we expect them
to", let's do that as a single file system specific test.  Let's keep
_require_scratch_swapfile simple.

						- Ted

