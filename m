Return-Path: <linux-fsdevel+bounces-62407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69AB917F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883BC3A7747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900130DEDA;
	Mon, 22 Sep 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dnpn51jQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB281309EF0;
	Mon, 22 Sep 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548788; cv=none; b=aG3p09ZCA49f7H1S4sWjafwAEooT32f6Udr/Gc4+xZyg4WYaPDCg5knfYRROtLQiOK9IxyAdQlN8a4Q/LDQ4NHVA9gP0IPndSfYa111P5IO5VNdx4hHvGfLp6kbwCnjcaRK1RG6uaxOkYYtvnyMA6WY7zkgtgh2yY4XB//1lVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548788; c=relaxed/simple;
	bh=1Na/PXc1OmcfeFacTEjh6XEbbpa3VJHswfhmNe3NbHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaZRfcOvPYl+SD+IRTG5GBHtjxPd3miT07AxAfO6ANpUTp6oekWwzsNDBV/K9R5ARlMieE/SMazhXMN9Q50m4XgnXTORzxv+1AQL+KFx4gAdXd0HJ4cxDmrRfUOb9X+l/hkxyzV56N8lOzLsjCFlT9B9jtoq8xvoJyLdxSUjCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dnpn51jQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z6fx5aNZ2ce4UxQDtdkE0266D9AEXw8fQmHwLhiq+Fk=; b=Dnpn51jQ/jwhmAayTj+/c8lCOz
	JMsiJ0IdL5xb1RnvvMui2lYvMH/70nVyC3dhnU2zfWd2n9SVo0L4P3yeG4rqZFk/565FsYS9tWNEi
	/45LkngeD1f0MOBZxA7CWERp75vJ9B6l/OAZdTcFJC8qdv1/hr4v8qFOtriGcOi4GWSRzIMt74gjT
	SIkTQY+LEjaDX7TLfzGdngqjmSa4FZQVhIlIy7xByREOEsL49Kbw3GHbolW7DfTW6avZ3FK9p52to
	jXWSHOr4V/FvFPbtb+uFB+pDEA1b29/iFIpnSk62/YTaph7rXFimJiOKO4e59f1W03OmGSyqUSNiV
	XpX4efFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gs3-0000000Frxq-2GAt;
	Mon, 22 Sep 2025 13:46:23 +0000
Date: Mon, 22 Sep 2025 14:46:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, kees@kernel.org,
	casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
	john.johansen@canonical.com
Subject: Re: [PATCH 31/39] convert selinuxfs
Message-ID: <20250922134623.GS39973@ZenIV>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
 <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV>
 <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
 <CAEjxPJ4Ez1oYXa4hEcSLSrO+ikLN0kgrWQc+2n2K7wWoy7a7pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4Ez1oYXa4hEcSLSrO+ikLN0kgrWQc+2n2K7wWoy7a7pQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 22, 2025 at 08:34:02AM -0400, Stephen Smalley wrote:

> Is there a reason why these patches weren't sent to selinux list in
> the first place?

Will Cc on the next posting of that series.

> In any event, yes, Android userspace (in particular the Android init
> program) relies on /sys/fs/selinux/null at a point where /dev/null
> does not yet exist [1]. Hence, I don't believe we can drop it since it
> would break userspace.

Pity.  Oh, well...

