Return-Path: <linux-fsdevel+bounces-10600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDC84CA1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DF11F20EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228859B69;
	Wed,  7 Feb 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXg83zgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772F59B5B;
	Wed,  7 Feb 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307265; cv=none; b=TKqWgT7xAXXECbvKYhBanxgR1nbWml14Yc+Fb4LRArMSG/wqTxaPRYKpnvZDJeY098dFm8tOYmSjmNNRrKINYfyYnC840Uad8/7Xf+aPyObKlmLAeEfnhlr1UubY0q6e6wbCyDTT2GwOFOFWCdJwu8oWInmAtu94a1hg9ILaGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307265; c=relaxed/simple;
	bh=oYhU2hLjtwChKJiF05doNBvPoVd8EBer/T75afDR0Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDt88cY3O2bLFCMD3org1kv7yypPuITGwzh7Zfe6hyhoZokWjl7D9FF6RHKJvJlZg8U6HQ8vSDNU9MNdP5oVbv40YVQEswwLcAX74DX9C0kwb76+lIDbHQjY82fWZ9WhR38ZHe59QNT4Yol8CIygqATqKS11YMrQsC86nNtsmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CXg83zgi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i5Q2EjVFD56Thy5YwUxsYl3ZKEbzYz5TtV7K+JoUogc=; b=CXg83zgidTJP7jUi+An6EZG38t
	zAHIWwa4fp3UGNjlupaHHQHw+fv+azPP1DBEqrPMeO2fMCkPi8eNSE3nx/qmpGFwj3PyNc231627S
	Wd9n7Ta7BJsuCl+OdpBVAG5dxyufVXgJ1GThGJCvrjjRARW8oojrFffjJgN/1My4NuqlaBuqbpean
	b59drlGQJnlTeDWf041ss+MQ9dPJro1Acsi07LbLZV/fd32UBRs8wktm1RyaheRLWE/+J75lU71ep
	k3hIERMr4G6KwGwZ4coM9uMGdqeORxb78z4EhnhTd4iSQK9Si6OJF/Ourl3kWpsIPrQr78Elq1h5S
	8Dqw+lwg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXgbp-0000000F3pw-3jRP;
	Wed, 07 Feb 2024 12:00:57 +0000
Date: Wed, 7 Feb 2024 12:00:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <ZcNw-ek8s3AHxxCB@casper.infradead.org>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <20240207110041.fwypjtzsgrcdhalv@quack3>
 <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>

On Wed, Feb 07, 2024 at 12:23:41PM +0100, Miklos Szeredi wrote:
> On Wed, 7 Feb 2024 at 12:00, Jan Kara <jack@suse.cz> wrote:
> 
> > The problem always has been how to implement this functionality in a
> > transparent way so the code does not become a mess. So if you have some
> > idea, I'd say go for it :)
> 
> My first idea would be to wrap all instances of E* (e.g. ERR(E*)).
> But this could be made completely transparent by renaming current
> definition of E* to _E* and defining E* to be the wrapped ones.
> There's probably a catch (or several catches) somewhere, though.

To be perfectly clear, you're suggesting two things.

Option (a) change "all" code like this:
-	ret = -EINVAL;
+	ret = -ERR(EINVAL);

where ERR would do some magic with __func__ and __LINE__.

Option (b)

-#define EINVAL		22
+#define E_INVAL	22
+#define EINVAL		ERR(E_INVAL)

and then change all code that does something like:

	if (err == -EINVAL)
to
	if (err == -E_INVAL)

Or have I misunderstood?

