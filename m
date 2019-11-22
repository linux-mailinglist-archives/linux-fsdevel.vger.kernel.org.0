Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758921073D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 15:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKVOEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 09:04:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727105AbfKVOEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574431460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2q8BeWxwacgujewzPlHSu9wxBhVQGOkSBQ10QL6E5DE=;
        b=JiXkEzNix7mxPNxc4C/3BcMAUhC2M9k0fQ0+75YqsAXssw+5CP1bfHlymtOGRp1Za50N8N
        BqJyVIi1t3UwY5r+/lv7/5f3kaycTItyZTl3AOG2kmnBjJ72Lo8FGqYpBIJWK03Ozco9yN
        /CU/YO5/23KfE71vQl1BnguoJHP99fY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-c_89Z3tGNAum7IGDdnziKw-1; Fri, 22 Nov 2019 09:04:17 -0500
Received: by mail-wm1-f70.google.com with SMTP id y133so3089009wmd.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 06:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aLdQYgS3j3Ft/M44UqQ7ursLLhMPIuR7gIPpOqg98qY=;
        b=XOtPmA8eZknp0TpwnhTvP5mmEFYo76y4ZVuN972C2KSNv4ni18VQvgfVQJcl8Vj1N7
         Mv6yLhMnQzuS6BVVXEn0GJyg6dFmlbK//i2yu3Pos29j8Ff76kJDNd2eiObfbnv3kLro
         iMI/ZDr8HyQhrg83id/aKR+SWeo2FiTyC6N5vteJyoYfe+lkpEMczOEZB2dHtYMjcA6I
         kcNsXowgsEDg1KUBR2JIUQbajByeowtQEPE0ONZiXW2ugR1qnEQi6Pa657PYM0ibfGYb
         7qN3Z0yliEs43ynEAStVkMNcwCBP4wv91ye3xwvqoFrluBitpwAF05eSr34gQM8zgcVa
         nw/Q==
X-Gm-Message-State: APjAAAXO7nw0BpJ6u/L1CAY8lNyu8WA7423w74xENAqAVA32kJLfKEzA
        dVstGFcFKuK+Gg/Dw2ZOwbiCgmGAfZaSrIMpL2SoI+h5jIKApIvsldBACDQ61RMHQRFm0jtyCzp
        beIM46QGcyFIADPdL8LuPEuC62w==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr4452250wmb.14.1574431456088;
        Fri, 22 Nov 2019 06:04:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzb8hUBOR4wKq3SC32QstFPmpTIIH/sKMH2KWj56BMRGw5/v19yYC8iE0zDsWPP0K0ktGtSJQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr4452239wmb.14.1574431455939;
        Fri, 22 Nov 2019 06:04:15 -0800 (PST)
Received: from orion (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id t12sm7388911wrx.93.2019.11.22.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 06:04:15 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:04:13 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        sandeen@sandeen.net
Subject: Re: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20191122140413.2o3sc67nvb2fsudh@orion>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
 <20191122085320.124560-3-cmaiolino@redhat.com>
 <20191122133726.GB25822@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191122133726.GB25822@lst.de>
X-MC-Unique: c_89Z3tGNAum7IGDdnziKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 02:37:26PM +0100, Christoph Hellwig wrote:
> Looks good modulo the changelog placement.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I meant to move all changelogs to under '---' as I did on the previous vers=
ions,
I forgot to move them this time.

Do you want me to re-send, ripping out the changelogs and keeping your
Reviewed-by?


>=20

--=20
Carlos

