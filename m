Return-Path: <linux-fsdevel+bounces-62494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 464F0B95798
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94767A2231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CE32142D;
	Tue, 23 Sep 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf3ZLhwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B031DD87;
	Tue, 23 Sep 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624254; cv=none; b=u98E0uhxFFqYaxrZ7ijKydnV0k9MpkwZGAfjq11l/zBBpsjyuJlKyzr+15XsZ0m9VpI7Sk/OsZ1EvVqxqLopi4LqMzKchJh/njbfoetaimmTng3MCDh0Xf0QdWL21fkZMUx2XEMyAVJ7z7OIe+BHFDkQIR0WDnxSEtD2k8v4jS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624254; c=relaxed/simple;
	bh=oeM0MATO8QJVvLW+x4CKlTANx7gTarxXI2pjbjYrmw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qphelyUYMTf30LVW3j5jGDIGjEce62piPwVCVUEZIa3IIa0L2iYF5HT8SSbpW7FhwzW24gWxAyBdbT+88rUM2cQZs5eWO/DO7Qfgz3HQ3pxNb3rOCpT31X4blnH69LdMGW/K7AtBaI7xQlaFYz9yUHH7o8c3uuIsCzqTH6MRyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf3ZLhwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1B5C4CEF5;
	Tue, 23 Sep 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758624253;
	bh=oeM0MATO8QJVvLW+x4CKlTANx7gTarxXI2pjbjYrmw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rf3ZLhwWUNsLQk+XMwVJDlA1h6WRVm8N/d6g/nocw77JDagTrd24YRnly1d+7TLXY
	 aa5Lx92TQtAh8eJbUxk+QBkZVFYOsS+LC4hDPGzbTe0eztQX9/moQrP66gI8QgKH/X
	 YIivf85pFovgzUcC50tEQw+oXDhQPQkxhP+kBS2Sdfgwcu4jEstSvSGnrNgE4TSMly
	 sKtKFAv62NfJYMb/XO4Rs6h+8g0Y/A7yEyb6wiOm8EX2eZjfY+iHvWZCfJMZVh4vcY
	 2ixdcLVZs0g3OLvY2tPX1hiosx7zcMbpSbbqUzB8Gcre32Zf6t+hddLfUrqdTHjlOp
	 CxVDU9ZZ/VMYw==
Date: Tue, 23 Sep 2025 12:44:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] mnt: expose pointer to init_mnt_ns
Message-ID: <20250923-altgedienten-spurwechsel-1b3bbed20edc@brauner>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
 <oqtggwqink4kthsxiv6tv6q6l7tgykosz3tenek2vejqfiuqzl@drczxzwwucfi>
 <20250919-sense-evaluieren-eade772e2e6c@brauner>
 <b4mb3kj3v453gduhebg5epbsfvoxcldpj3al7kjxnn64cvgi57@77pqiolvgqgt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4mb3kj3v453gduhebg5epbsfvoxcldpj3al7kjxnn64cvgi57@77pqiolvgqgt>

On Mon, Sep 22, 2025 at 12:19:11PM +0200, Jan Kara wrote:
> On Fri 19-09-25 12:05:16, Christian Brauner wrote:
> > On Wed, Sep 17, 2025 at 06:28:37PM +0200, Jan Kara wrote:
> > > On Wed 17-09-25 12:28:01, Christian Brauner wrote:
> > > > There's various scenarios where we need to know whether we are in the
> > > > initial set of namespaces or not to e.g., shortcut permission checking.
> > > > All namespaces expose that information. Let's do that too.
> > > > 
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > I've changed this so it behaves exactly like all the other init
> > namespaces. See appended.
> 
> Yeah, looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> (although I can see you've kept my Reviewed-by in the patch).

Sorry, that was an accident because I had amended the patch.
Thanks for paying attention to this!

