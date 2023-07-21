Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0275C95C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGUOOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGUONw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:13:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0330DA;
        Fri, 21 Jul 2023 07:13:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so286616366b.0;
        Fri, 21 Jul 2023 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689948823; x=1690553623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTiZKWG+Cif6uSGkqVpSsZKmtuHMIC5BZBRXp3RaZY0=;
        b=bSgkkzhG7An9AVoKrMumbL9xiXL380xIZJEvmrmx9U5srM+FpnU6DcxDMgm07mM13S
         aJ5Shp3X2vMXjR7LimidZ7jIBh0VSrmUVHMIp/qymsNfJ+UuAa+kuh8JjfQ9YIIyEjkN
         pUANto3pLHm7EJFSmodEypW4yQO45th4XEXHDTgV+nTSmFasovRamFUpw18jONRUL7V1
         z19+OTH9uMgrSZEgiBUlP7c57WePcxTEn8bsEuLdB8msbWseXQm8tkIudZ40bLgpjSAh
         Mf9vFF5kMUbeQmOCtDLMTtrlIDTbbzcM2vhoEe1Rtl4YD96AmuH165lnh4fp7pTBJ1+Q
         Vowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948823; x=1690553623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTiZKWG+Cif6uSGkqVpSsZKmtuHMIC5BZBRXp3RaZY0=;
        b=Z52KEp7IrdrSmNAhf7GlUNum+I2HIaMjUhMA2V31aBtwk5iS/NrRi+uszLg/OPjBWE
         1UjE7ULygVFQFKiN+PNN+m1/hfsjTHgN89be0872M8kTopj5SeOSzVMHlj4I4SWBocAz
         hxW7OOG4fxHb0KttUWJqOif+rl5CuvgW+/U1vXSZBXSuspzVFQB//oEJQLXzNhAsGKTH
         3RSe8luDjNAk/AOZrG458X/Znw9Qr1Zimxdaoz7UIlaU3BKwvHIBVEQoE4YcR8pL8lbX
         ja/PAZYmWoKhEEdZO/5x9aXgy3hZxJbaHJ8u5IQGEEus2U2+ScxaJqnfd+kAfF8X0e+7
         Mc0Q==
X-Gm-Message-State: ABy/qLbaKBFR90bFgb5U8nk46U8muuY80LSIjqN1GgE9wRh6LlXfINex
        0IA7zlF3JwWJb/89xgRsDdc=
X-Google-Smtp-Source: APBJJlENisEswjkwjMzFaJUMeB0ZRr5qmTZQOFikJvyqr9lFw+jEk4LumhWtwqhqMCkGqCil+5TJOw==
X-Received: by 2002:a17:906:5386:b0:974:771e:6bf0 with SMTP id g6-20020a170906538600b00974771e6bf0mr1626532ejo.56.1689948822336;
        Fri, 21 Jul 2023 07:13:42 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id mc13-20020a170906eb4d00b00988c0c175c6sm2213577ejb.189.2023.07.21.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:13:41 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 21 Jul 2023 16:13:39 +0200
To:     Baoquan He <bhe@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZLqSk0KgEiqn/9AA@krava>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:48:37PM +0800, Baoquan He wrote:
> Hi Jiri,
> 
> On 05/31/23 at 01:58pm, Jiri Olsa wrote:
> > On Thu, Mar 23, 2023 at 10:15:16AM +0000, Lorenzo Stoakes wrote:
> > > Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
> > > introduced the use of a bounce buffer to retrieve kernel text data for
> > > /proc/kcore in order to avoid failures arising from hardened user copies
> > > enabled by CONFIG_HARDENED_USERCOPY in check_kernel_text_object().
> > > 
> > > We can avoid doing this if instead of copy_to_user() we use _copy_to_user()
> > > which bypasses the hardening check. This is more efficient than using a
> > > bounce buffer and simplifies the code.
> > > 
> > > We do so as part an overall effort to eliminate bounce buffer usage in the
> > > function with an eye to converting it an iterator read.
> > > 
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > hi,
> > sorry for late feedback, but looks like this one breaks reading
> > /proc/kcore with objdump for me:
> > 
> >   # cat /proc/kallsyms | grep ksys_read
> >   ffffffff8150ebc0 T ksys_read
> >   # objdump -d  --start-address=0xffffffff8150ebc0 --stop-address=0xffffffff8150ebd0 /proc/kcore 
> > 
> >   /proc/kcore:     file format elf64-x86-64
> > 
> >   objdump: Reading section load1 failed because: Bad address
> > 
> > reverting this makes it work again
> 
> I met this too when I executed below command to trigger a kcore reading.
> I wanted to do a simple testing during system running and got this.
> 
>   makedumpfile --mem-usage /proc/kcore
> 
> Later I tried your above objdump testing, it corrupted system too.
> 
> Is there any conclusion about this issue you reported? I could miss
> things in the discussion or patch posting to fix this.

hi,
thanks for your reply, I meant to ping on this again

AFAIK there was no answer yet.. I managed to cleanly revert the patch when
I needed the functionality, then got sidetracked and forgot about this

I just re-tested and it's still failing for me, would be great to get it fixed

Lorenzo, any idea?

thanks,
jirka


> 
> Thanks
> Baoquan
> 
> > 
> > 
> > > ---
> > >  fs/proc/kcore.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > > index 71157ee35c1a..556f310d6aa4 100644
> > > --- a/fs/proc/kcore.c
> > > +++ b/fs/proc/kcore.c
> > > @@ -541,19 +541,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> > >  		case KCORE_VMEMMAP:
> > >  		case KCORE_TEXT:
> > >  			/*
> > > -			 * Using bounce buffer to bypass the
> > > -			 * hardened user copy kernel text checks.
> > > +			 * We use _copy_to_user() to bypass usermode hardening
> > > +			 * which would otherwise prevent this operation.
> > >  			 */
> > > -			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> > > -				if (clear_user(buffer, tsz)) {
> > > -					ret = -EFAULT;
> > > -					goto out;
> > > -				}
> > > -			} else {
> > > -				if (copy_to_user(buffer, buf, tsz)) {
> > > -					ret = -EFAULT;
> > > -					goto out;
> > > -				}
> > > +			if (_copy_to_user(buffer, (char *)start, tsz)) {
> > > +				ret = -EFAULT;
> > > +				goto out;
> > >  			}
> > >  			break;
> > >  		default:
> > > -- 
> > > 2.39.2
> > > 
> > 
> 
