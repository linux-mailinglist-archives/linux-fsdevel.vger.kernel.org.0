Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9C306E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhA1HKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhA1HG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0AC0612F2;
        Wed, 27 Jan 2021 23:05:46 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r14so5087623ljc.2;
        Wed, 27 Jan 2021 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6Ja0b6no5eZDxYMF3LcCjisrlOc+aXrwQbbpI1j+FU=;
        b=vR3wxqh/qmhwGrbVwupmBVa176b9HWbzlBi+iHpE2Ycg3SLdVUaFFVWJRoDflvOdUM
         aWsfXml59wmBYin5SlN4xPN6RcIK4dNQcXmOWado8NdbDeiQYMEx9jUwc2FSefBaZsTb
         UppvhET8UGl0VaK3nPfEI3NeSolRoxAjUmD/Twjh8E4UabvGtnBhvdK4Pp/0MfZgKspn
         EbnXKBnWSLwOuA8eGVoZOC1ie3IunASVVcj3NKoElHEMt6SbJYta7lDwO2SMVvg2m/by
         5Dg/ReU5K8DaNZiZQw6REGpMyc2vLhV0PBbGGTcgWEnqc/YsiI2u5nxThcqW1igtLrDg
         FA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6Ja0b6no5eZDxYMF3LcCjisrlOc+aXrwQbbpI1j+FU=;
        b=K4JqbH8wUDlP7lFfPGYVY7wrFfnhHQGNU5Trq4enNO1XIGPg5B3nWAFCQ/U7KEJ0Pw
         Xs0qkA4hz5m03J8Ata3pMF70gj3FX6qOBRNK/x85SO4hhv/6ct5+kYloyGSI8ccJwMKE
         Agr1UJp4Ul7uH+npAtYIgIT9fnIpPlSL7ABL9k5+O/yKfx2ZP2eBKPydEdgZsZ1rl9zc
         yvDY01QIbd9c0LNRDE8+tj3xVCFiDIXqCknZg9tt7mayjHwzYh+buKQpQ8wYM4oWso+K
         gRNzTyqtVyNaS8TqAuAOYy+4he+gUzNTK3qAJ+okiFfz07bbkjB8b6K4PjXQCO3oXxTV
         edVA==
X-Gm-Message-State: AOAM5330UdMKEX8VvlVhsh3ASdHsQMpXrsAJLKRQSGdUK1eniTMWlDyC
        qlWBJA7dQQ6ZfCVplSR21UAiSlXdyQBeFg==
X-Google-Smtp-Source: ABdhPJyBKxRLdlULivn3zwS67VsgEmgyzQZjno9E0hYhphWAEuj721B0R/ffUiJ+gvuTBqvxO9A/aw==
X-Received: by 2002:a2e:964f:: with SMTP id z15mr7511737ljh.368.1611817544692;
        Wed, 27 Jan 2021 23:05:44 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id r2sm1324510lff.143.2021.01.27.23.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:05:44 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:05:41 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Mark Harmstone <mark@harmstone.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v18 01/10] fs/ntfs3: Add headers and misc files
Message-ID: <20210128070541.ynzsgpniyo2xe23k@kari-VirtualBox>
References: <20210122140159.4095083-1-almaz.alexandrovich@paragon-software.com>
 <20210122140159.4095083-2-almaz.alexandrovich@paragon-software.com>
 <45515008-e4a9-26e3-3ce4-026bfacf7d53@harmstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45515008-e4a9-26e3-3ce4-026bfacf7d53@harmstone.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:55:30PM +0000, Mark Harmstone wrote:
> On 22/1/21 2:01 pm, Konstantin Komarov wrote:
> > diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c

> > +static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
> > +{
> > +	if (chr < 'a')
> > +		return chr;
> > +
> > +	if (chr <= 'z')
> > +		return chr - ('a' - 'A');
> > +
> > +	return upcase[chr];
> > +}
> 
> Shouldn't upcase_unicode_char be using the NTFS pseudo-file $UpCase?
> That way you should also be covered for other bicameral alphabets.

return upcase[chr] is just for that? Upcase table from $UpCase is constucted
in super.c and this will get it in and use it.
