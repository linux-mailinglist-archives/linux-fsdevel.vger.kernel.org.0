Return-Path: <linux-fsdevel+bounces-16972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794EA8A5C8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F5BB2290D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6615698D;
	Mon, 15 Apr 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T3D/TTc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB037154452;
	Mon, 15 Apr 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214841; cv=none; b=CFcl5i2M6ohMaw9nsGnsakfBxullHdt1YcKWkTt5H7DEyK1Zco2XYKCzjXxULBhXjW+Lg0o+gdqDJhZNBbGUMbOZj2GCXssciZU38YLeysp5mjKMF3CbVJIb2Rf0K7Vq9aybvNsnTkmJn3hAeRq5PwwEcUq7t+gMad4a+Gt5Ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214841; c=relaxed/simple;
	bh=SUdVdoOMMcKuE6T44gDXZc9Du5rZohlYcfTiT1o0FTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbzWxYyhbchYn1FLp4ygRQGxdf45AXS/e+VVRX505bn5znP4nenGtvq5vrZOu+fr9NWooXwARjXkVR6SQMwlu19bPwKHqNKEe3KLuZo08KIoAYvpWFimanVp2kz3vf2a8o3xIjcdc7IBPcLdW4xezXYRLaUTJJM+ZaOnTGWYJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T3D/TTc6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=YtPwJPZSjzsq4Aj/scT6HbP0Qc6Mf3kzhzhzkus5EP4=; b=T3D/TTc60g+XvgrjxjXkGQ8mq/
	TFP+ivSh8MZ4hzKCWDtW21By0e5UV2ccTJaw5OO7ecqi00Y1IhDtAbO9/fugrsItm7HgaSFAQQNgE
	yaBWmHfDf9ov3jTAjO2DazEk2HReBwa2rmGnmE/UsQcHinQIuTA26ms5j1XpbKGbvcVuXDf8x/8Lo
	jiJsXXuqNqRbqmtAbLyXMLv7RgJ/NLYw5lZPtLETz/qzu4YXdOzPkLqBU6kSSCvfjpLFQSPWMSvSy
	mlwhChPgZ1BH0K/x8prUBnlrn5CQTNULv1WZYtrRCClnSLPmGQIXWoOTvlpTcrUmraVkSGhv0sXWW
	VAkhM63w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwTRL-00D0xQ-13;
	Mon, 15 Apr 2024 21:00:35 +0000
Date: Mon, 15 Apr 2024 22:00:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
Message-ID: <20240415210035.GW2118490@ZenIV>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 15, 2024 at 10:47:59PM +0200, Christophe JAILLET wrote:
> Le 04/01/2024 à 14:29, Christophe JAILLET a écrit :
> > Most of seq_puts() usages are done with a string literal. In such cases,
> > the length of the string car be computed at compile time in order to save
> > a strlen() call at run-time. seq_write() can then be used instead.
> > 
> > This saves a few cycles.
> > 
> > To have an estimation of how often this optimization triggers:
> >     $ git grep seq_puts.*\" | wc -l
> >     3391
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Hi,
> 
> any feed-back on this small optimisation of seq_puts()?

> > +#define seq_puts(m, s)						\
> > +do {								\
> > +	if (__builtin_constant_p(s))				\
> > +		seq_write(m, s, __builtin_strlen(s));		\
> > +	else							\
> > +		__seq_puts(m, s);				\
> > +} while (0)
> > +

No need to make it a macro, actually.  And I would suggest going
a bit further:

static inline void seq_puts(struct seq_file *m, const char *s)
{
        if (!__builtin_constant_p(*s))
		__seq_puts(m, s);
	else if (s[0] && !s[1])
		seq_putc(m, s[0]);
	else
		seq_write(m, s, __builtin_strlen(s));
}

