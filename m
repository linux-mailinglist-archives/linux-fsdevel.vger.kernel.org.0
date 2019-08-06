Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20B8311D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFMCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 08:02:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53750 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFMCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:02:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so77933840wmj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 05:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wHQFNmeVP6Mz9p/qPLSMEtgNuo5A4SnlHGlMfLY7pAY=;
        b=JMYiw+RRjiYCqPeuOJB43TzaLISqOxtcOyaezoEQlIvmb5SzquCQIGJgvul62fLEV/
         jEu23oziI4vQFmMtoYlM1dOtlL5PaDCDxDx3C3Df+vm+O6z+6d8TIEtn+MMYIHr5Rhb+
         wYj0+6zVUWaL48FCKDvRliX6fjMV3Hr+48oVWtyxXDjn50e1EvseW6PWPNsoNRb85d+w
         /Wpv+elqcsTtlvLeFl3MOl7p39TwI0UpghFS+oRkJB7hhWwQuOFCZsukNFrNnHgSflAv
         Fqrp5Qyl1yJE2M/bY83HCEq3NifvvCRCJvy+J/KChPcvDLpJ9Af44B+VRWuNLtp4wE3U
         ML6w==
X-Gm-Message-State: APjAAAVQ1D7H/Ygv+XgQG/WtBbZ6y9J4rhzGEygveKNlFFSOcRhX/YHi
        3lMbJRRUJf/4Kuy/9R5G2n8t3w==
X-Google-Smtp-Source: APXvYqyNYp59Nf2CiXgRplQObJg8sXWpHRPOAHNT0H1wFEwIFz7Gl+qNvF9vIn8JtumWH589n7a/Rg==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr4570200wmg.48.1565092969970;
        Tue, 06 Aug 2019 05:02:49 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id n9sm135142887wrp.54.2019.08.06.05.02.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:02:48 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:02:47 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190806120245.3qestwolyjtaky5u@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805151258.GD7129@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'll keep my reply to your email short here, because hch's follow-up email
summarizes what I wanted to say, so I'll reply to his email directly.

> : 	return bno;
> : }
> 
> > returned. And IIRC, iomap is the only interface now that cares about issuing a
> > warning.
> >
> > I think the *best* we could do here, is to make the new bmap() to issue the same
> > kind of WARN() iomap does, but we can't really change the end result.
> 
> I'd rather we break legacy code than corrupt filesystems.

By now, I wish to apologize Darrick, it was my fault to not pay enough attention
to iomap's bmap implementation as you mentioned. Will keep the discussion topic
on next e-mail.


-- 
Carlos
