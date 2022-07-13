Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDD573CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiGMTJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGMTJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:09:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644515A31
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:09:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dn9so21511335ejc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=75dAHpzz7HRb5HORG8SCgwBTYFSSv6+GS55I/0F+VwM=;
        b=BHuyZ7wU3N4SSBB44CGvEV9eWdAPGrHxXnBgFh5/1+IpQ0QqpGBQEP0Ekr66lbvQSh
         3E3ShCNu7MGHKlnFvTEsk2ZDU1xo5yPXYIn+zvLsukeOQvWkTwH6fT9Uui9zXSfkmJtS
         VRwzJUdub7wbU6aC8+HCv5D7eC7sRxfz989nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75dAHpzz7HRb5HORG8SCgwBTYFSSv6+GS55I/0F+VwM=;
        b=ipF++hkrNiJMvKykzEIc8gTB5jkxpKIBSudgB+X3uNWBscYDG1eV6l2LlAsJioc37S
         HL3zrVt2iwKRqoR9w3kxTCF9y3DWJHjqU5wY7vArOiAEU0rjwFjfQskpXi23cm66Yuk7
         z8FOFIZxdErNiIYtfBU0c5uECuTMVfK/2s+Vl0pufjHUylfG982cVeGMy8J4ZDzkNLA9
         mpn6yy76002Jfy9+K6d+XxIu5M/HFkZuMacJRU7B3fE4VruEX3EQnv7ygs0o6DbypYuP
         pt3DhXcUk83kEKTbvHRi1HslUi8ueOypUmaPptYbVh1QGrxmMoaQLgbGHmo9McoB7dSc
         Jy/w==
X-Gm-Message-State: AJIora/SJiDQ2XmxNow8/0jz0imGT9wdhhoOojwxJuBKB0dv90oArK1+
        fYArKuBBfweTt9LRRrZleeDn1owg47DwBBn9c9M=
X-Google-Smtp-Source: AGRyM1ufEeZrzRJWxHLH2FEzyDaOO+Vc7vUhLUpcKdzvdVr9Im/x3nM9w1PYBoWxHU6OrJPO+y+bAw==
X-Received: by 2002:a17:907:b0a:b0:72b:3176:3fe5 with SMTP id h10-20020a1709070b0a00b0072b31763fe5mr4909961ejl.48.1657739386248;
        Wed, 13 Jul 2022 12:09:46 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id r24-20020a1709067fd800b006fe8b456672sm5318048ejs.3.2022.07.13.12.09.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 12:09:44 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id h17so16864217wrx.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:09:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr4758792wry.97.1657739383678; Wed, 13 Jul
 2022 12:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de> <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
In-Reply-To: <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 12:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip=9-_w5s=g0BkuLMEufjV25QkUASZ_9NwY_a=O+BR9g@mail.gmail.com>
Message-ID: <CAHk-=wip=9-_w5s=g0BkuLMEufjV25QkUASZ_9NwY_a=O+BR9g@mail.gmail.com>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually deduplicated
To:     ansgar.loesser@kom.tu-darmstadt.de
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:51 AM Ansgar L=C3=B6=C3=9Fer
<ansgar.loesser@tu-darmstadt.de> wrote:
>
> This is my first commit, so I hope it is ok like this.

The patch was whitespace-damaged (tabs converted to spaces, but also
extra spaces), but with something this small and simple I just fixed
it up manually.

               Linus
