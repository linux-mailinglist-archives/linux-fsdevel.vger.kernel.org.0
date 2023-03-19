Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451936BFF91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 07:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCSGS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCSGS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 02:18:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1204E1B5;
        Sat, 18 Mar 2023 23:18:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m35so5567079wms.4;
        Sat, 18 Mar 2023 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhqo9SbWO6qq+Q6ia+mS1H3WpBHGnRuwtscD7xGcrHs=;
        b=hjWICnSUfd0FkUjbaUaU1k+9N+t8FYxO+nuJ9xLlmVvPlAECNGAK9WTDaxxMKjd9m5
         wYwSJ3RMS5bM4TYXF5vkL/6Lxg9regvlkqPvb5Hm29Zx8AF/XFWoMaYDABSM8o1h9EpA
         wIL0wqxOlvspIY47Fi+6nAi4bWher6S0Vp/4eKy6q2i+c2dnLN9M+uMI1sNx+fX0W/e7
         eksq1Hlo9g4x1yhs+DHG/s1c+kUO9dCgpePvrtJmPoBEspRFt2TGOjd0/72bxtN1ZbBU
         B1x99P0gFZDJPcRGYNaNqyvykcUY3iSMAQUIXHnLRhl03BNIbErH2QTncAeiKsH7TOUI
         KoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xhqo9SbWO6qq+Q6ia+mS1H3WpBHGnRuwtscD7xGcrHs=;
        b=wKXoSrwBBraN5mJV6ZaYyDDaS7rvnpVoIYZk/tAHBj6RHE0mEdfFPlDV/+80FKwxXK
         QswP1zvNz3aiBBoDkRyjIJU+uFYiAq6OUIVbn0JYiGOkw8/f8VuFhJHa5pzZoFGUUsBy
         Jxz7YCBTNW9pR+hXw/0rRl/HVxAb/srayvdm3DliQTawyrbodIN5bbvzZ95n0KaZejrd
         sTk3w9OXGnabjM8v01ojUB+tHO2xP0FDpawahmJYQQSvcz0ja6dsanJ61iIQ5STCMX2h
         X1T05L8Zz4dc1jz7ui/fUQnVLQ00P+ElForW8oMizzDCAallT5TcXhjUVr68ICIgpwFS
         QFZA==
X-Gm-Message-State: AO0yUKWt0mIwV7rw5xEZimjmJXZcVuLy0SVdePvX1NPP+DvZGdHM5+dk
        zkNag3AFyOeDdKh/uXRRwsk=
X-Google-Smtp-Source: AK7set9KqR9HZ0+RJIp4qsI7IbQOymXJCYcLZalOuh1caFBzureR/W9BTPBITqoJSweFKvxCR3hhuQ==
X-Received: by 2002:a05:600c:190c:b0:3e1:fc61:e0e5 with SMTP id j12-20020a05600c190c00b003e1fc61e0e5mr27919904wmq.33.1679206704320;
        Sat, 18 Mar 2023 23:18:24 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm5868560wrr.17.2023.03.18.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:18:23 -0700 (PDT)
Date:   Sun, 19 Mar 2023 06:16:13 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <d3582147-707d-4d8d-b062-3de7aa898928@lucifer.local>
References: <cover.1679183626.git.lstoakes@gmail.com>
 <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
 <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:50:56AM +0000, Matthew Wilcox wrote:
> On Sun, Mar 19, 2023 at 12:20:12AM +0000, Lorenzo Stoakes wrote:
> >  /* for /proc/kcore */
> > -extern long vread(char *buf, char *addr, unsigned long count);
> > +extern long vread_iter(char *addr, size_t count, struct iov_iter *iter);
>
> I don't love the order of the arguments here.  Usually we follow
> memcpy() and have (dst, src, len).  This sometimes gets a bit more
> complex when either src or dst need two arguments, but that's not the
> case here.

Indeed it's not delightful, I did this purely to mimic the order of
copy_to_iter() and friends which place iter last, however on second thoughts I
think placing iter first would be better here where we have the freedom to order
things more sensibly.

I'll respin with a fix.
