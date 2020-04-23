Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7087C1B5429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgDWFYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWFYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:24:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB5C03C1AB;
        Wed, 22 Apr 2020 22:24:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f19so5106621iog.5;
        Wed, 22 Apr 2020 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHhB9hcSkC379vsdgiDLPZBRxAMpvpMAKOY03SWCDKU=;
        b=CnN0Oy0DhFpBLR4yXWEroayRGTCvWEoGEIW0y3znyFdXJuBpn+itSmm8QdJW71a9DC
         tJCQhYmFhLPXcEWOXOEkYKLgwpZwPnkWZloRCnEHfn/zkNwdlegyKyVxF4DafE24N+pB
         q8T6WHu9iK86mZx659rc1Bq3r8bdUIudXrpz2IL7HSSr8NyR6s182mVtq4HKiBlKj0im
         Kw7kAHffiHxEEot61ZIv0n25iQpUZuwVtUxObqOHHQYxl/iAJz0YUteWInYkKeiHu8rZ
         2sJT7cvLu4yhf6lp/+1T6w8+Pa0q9l2CxGPfM1KfNSAPJNPAdbZYsTkzSken/v0p3mrB
         b2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHhB9hcSkC379vsdgiDLPZBRxAMpvpMAKOY03SWCDKU=;
        b=eCjGXJlEXZbg4LI2NeFI5PrPCeMbjQB4zKCE/51MI0+S0DJCqlBzKrp2Aer4Im24sT
         icuPynu8496+ys72DvltGG2nKZqF4ZlRLjwUb7KsCa4aoZA+TvKioUoVF7nkzu12eTiM
         oCrXzxuHvnNXni6ZrcagOBiDNE04FiP3P3vmcjQz5qlGGeZk5UlQ8xkE2z9FYp4sQ9uo
         RzjHBKj6p9Oa71eK81k+dECAqnQiqGjzfnKBfirJhFeYXRqejAVcM54b6Zyabvaj2AUW
         1aA7TyVPHMf2bwwirlPavOfhXFFgHQqiV+5bhZzl+VxMlx8npGEMcnxQfB41NvD/JQx+
         H3/w==
X-Gm-Message-State: AGi0Pua34ZKINTDgzODDJn2Dtc6tRDHsL6/6dDY1u0DnlFgLYkCTUsWp
        nqAZkhsC1Yx+ugWOK78UKnGWMcEC9GbWlh5du8wgww==
X-Google-Smtp-Source: APiQypKCdVoF7c+9mG5LACGahDiXeCZ+C0X+kYX7Cnypq4uFInUtDvl04W72tnXp1eXclxj+2dTlmAFW7yWVK5U5pno=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr2087744ioh.203.1587619474830;
 Wed, 22 Apr 2020 22:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org> <20200423044518.GA162422@google.com>
In-Reply-To: <20200423044518.GA162422@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Apr 2020 08:24:23 +0300
Message-ID: <CAOQ4uxgifK_XTkJO69-hQvR4xQGPgHNGKJPv6-MNgHcQat5UBQ@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:45 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > While reading the famous slab paper [1], I noticed that the conn->lock
> > spinlock and conn->list hlist in fsnotify code is being initialized
> > during every object allocation. This seems a good fit for the
> > constructor within the slab to take advantage of the slab design. Move
> > the initializtion to that.
> >
> >        spin_lock_init(&conn->lock);
> >        INIT_HLIST_HEAD(&conn->list);
> >
> > [1] https://pdfs.semanticscholar.org/1acc/3a14da69dd240f2fbc11d00e09610263bdbd.pdf
> >
>
> The commit message could be better. Just to clarify, doing it this way is
> more efficient because the object will only have its spinlock init and hlist
> init happen during object construction, not object allocation.
>

This change may be correct, but completely unjustified IMO.
conn objects are very rarely allocated, from user syscall path only.
I see no reason to micro optimize this.

Perhaps there is another justification to do this, but not efficiency.

Thanks,
Amir.
