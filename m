Return-Path: <linux-fsdevel+bounces-15055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3B88669F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F671F23241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA9C133;
	Fri, 22 Mar 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH34rL1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C08F6F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088018; cv=none; b=RBzhmS2MSgfE7Wjc2RVpWrnP9Aj70H82a5kMKe/rd/z2dj9WXmzqLJ9JS7gulDJHf1JkuNqQqX5oVZNnAFpllVt/ripfTNuJcl/w/bZf5Tlctg/Yrs8lDRVOa14qZhPku519mJ60U9exwbkLLXV6u/BdQja5QY9u6UA2tXNN/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088018; c=relaxed/simple;
	bh=13n6vEx0RKsPduTpGL8LKKNQYLIk+cUJACRS11LHd5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coZsc272pxY1bhSGev7WZEY1HY9W6x3H96UJNoVe0eYmcR8A50YIh8I89vFv4lvxKCJsENh2rRxvjZzA57ufrJhU3GQzeB+FRasJm6HmTEc6phTBpKeg3tjGqtU23ugHtuy5zTfpuO0SBEtkcjDY2+0IKKgaQR6rd6VirOoYaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH34rL1H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ff53528ceso1027366f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711088015; x=1711692815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjqo6wElKZtgGNj6GGnnTBQeXO+eE9diL9uYn1NC34Q=;
        b=yH34rL1HQkn+GtaR/e1SwxD3zU4FLBOokBopUvKX/JyacdjiGSibmtVaxoOaGmGk2x
         4yJxCIFJzBNjnLYeiIoxbEg9dPUP+Xx+aysbURa5jn802e63pxqaR3P2D0qHrdkVYGc9
         s7VLxVPv0PM7LBB/2e0xWC5aEjrbrVhkNy7dmGPnE4dtq4vBxh74Zse7iccg/zhN7vOg
         iDW8x6vlfaHKsCefVfgg8qM3C/A+AG+g2RpOerJdj8jAdHBsbotrA7+Uc+FF6onuMS9T
         PdKKqIY7a/hkrVAfvXGjSEuaIfqroSEmBZ9iwiHJfy+vHuJdByjjkPisIolq7q3sYE92
         7RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711088015; x=1711692815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjqo6wElKZtgGNj6GGnnTBQeXO+eE9diL9uYn1NC34Q=;
        b=a2xMApNcduNqN+gFkhu63wwmFNcY6TJRL0xsHZ/i7SMGjLYkKndb5HoRcWh76/lrR3
         poK5z3kv7tEZAarj7Hf7FUljHAS96oazXz8vVCMOqR8hE69meozrxWXweLuiHAhA4xUW
         R2WGJ8GUvC2VC6HzwJfcrArKGRjnY3Evf4ZNJ1D5uWCMu6G5QNoT/36VYgmpatq7qZcM
         gKZlK7g5+h7qGB4L8F58gaLUcBha+UJ/6DS7KyEbyBD2ux/rBVljeaapw/BszfgE1Gp0
         HvCMuBoiwqU38Oxh+bSYGnq/Vz1EgRRuCAZ0moC33SMFtx3iC0pV34/1JQ51D0NsSrvl
         kcyw==
X-Forwarded-Encrypted: i=1; AJvYcCXaY+91cfjAXkaWEKqmvfdS0puI67eNBNAW6JP2dtqDJnUvAeuOaMjhN76LWvFjcg/zJzqBM54KWNWDcRYUjqmld0oeGAYNWd/zPgDeyg==
X-Gm-Message-State: AOJu0YxFGulgjva6yixTo9LTPE4LaUdHpoQ20xzLBvfGhLmetELOOiGU
	KIub2Lr89hyGynf258H2MsS6WTPJkN8hGywEotcMOMEcwGJcYwnNM7zi3zzu8VM=
X-Google-Smtp-Source: AGHT+IHm8OsbpGQ2JHUp5hBd388gtEhT3nrU3IpFVsVcGMJeNceWFfJltzX1vVpM68rf361cJgKaKQ==
X-Received: by 2002:a5d:6dc1:0:b0:33c:e396:b035 with SMTP id d1-20020a5d6dc1000000b0033ce396b035mr733113wrz.69.1711088014591;
        Thu, 21 Mar 2024 23:13:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b0033e192a5852sm1263895wrs.30.2024.03.21.23.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:13:34 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:13:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <fa490acb-2df6-435d-a68f-8db814db4685@moroto.mountain>
References: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>
 <171107206231.13576.16550758513765438714@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171107206231.13576.16550758513765438714@noble.neil.brown.name>

On Fri, Mar 22, 2024 at 12:47:42PM +1100, NeilBrown wrote:
> On Thu, 21 Mar 2024, Dan Carpenter wrote:
> > On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > > I have in mind a more explicit statement of how much waiting is
> > > acceptable.
> > > 
> > > GFP_NOFAIL - wait indefinitely
> > 
> > Why not call it GFP_SMALL?  It wouldn't fail.  The size would have to be
> > less than some limit.  If the size was too large, that would trigger a
> > WARN_ON_ONCE().
> 
> I would be happy with GFP_SMALL.  It would never return NULL but might
> block indefinitely.  It would (as you say) WARN (maybe ONCE) if the size
> was considered "COSTLY" and would possibly BUG if the size exceeded
> KMALLOC_MAX_SIZE. 

I'd like to keep GFP_SMALL much smaller than KMALLOC_MAX_SIZE.  IIf
you're allocating larger than that, you'd still be able to GFP_NOFAIL.
I looked quickly an I think over 60% of allocations are just sizeof(*p)
and probably 90% are under 4k.

> 
> > 
> > I obviously understand that this duplicates the information in the size
> > parameter but the point is that GFP_SMALL allocations have been
> > reviewed, updated, and don't have error handling code.
> 
> We are on the same page here.
> 
> > 
> > We'd keep GFP_KERNEL which would keep the existing behavior.  (Which is
> > that it can sleep and it can fail).  I think that maps to GFP_RETRY but
> > GFP_RETRY is an uglier name.
> 
> Can it fail though?  I know it is allowed to, but does it happen?
> 

In some sense, I don't really care about this, I just want the rules
clear from a static analysis perspective.  Btw, you're discussing making
the too small to fail rule official but other times we have discussed
getting rid of it all together.  So I think maybe it's better to keep
the rules strict but allow the actual implentation to change later.

The GFP_SMALL stuff is nice for static analysis because it would warn
about anything larger than whatever the small limit is.  So that means I
have fewer allocations to review for integer overflow bugs.

Btw, Jiri Pirko, was proposing a macro which would automatically
allocate the 60+% of allocations which are sizeof(*p).
https://lore.kernel.org/all/20240315132249.2515468-1-jiri@resnulli.us/
I had offered an alternative macro but the idea is the same:

#define __ALLOC(p) p __free(kfree) = kzalloc(sizeof(*p), GFP_KERNEL)
        struct ice_aqc_get_phy_caps_data *__ALLOC(pcaps);

Combining no fail allocations with automatic cleanup changes the way you
write code.

And then on the success patch you have the no_free_ptr() which I haven't
used but I think will be so useful for static analysis.  I'm so excited
about this.

regards,
dan carpenter


