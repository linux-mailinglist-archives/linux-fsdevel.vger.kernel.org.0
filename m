Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BD5FBDD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKWWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJKWWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:22:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C905192AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 15:22:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d24so14543976pls.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya+CrD6RQ5p1FsGwF6+V+S0eZMj0JP4hh6Oy/+hJ7f4=;
        b=EproxsXPwDwkz7NeJxiKx0xV5B+FL8MhUsL1YDElBzk+7TPFMlIrsgHkX7RW+4d1Rq
         0IneH/P6OX5ynCTdW9Do+GL+NnRCveMX4djAUkDdkk9HTHX1Jvsidm2r5UaOc3AHJYsn
         GIWDOT9fM78hYz/ouyodRkImJirjJdE+DEPDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya+CrD6RQ5p1FsGwF6+V+S0eZMj0JP4hh6Oy/+hJ7f4=;
        b=MwLTASKQBILfCtMePbYOCgrAVTSi/R4hjksajmHQqpMrIrhgFzzUwvI0eiU18eviEQ
         rCpTeiqY8NQvjO4d6VlJYFhPQ9YEAmRZMcl801BfiKQmnBczQVd0praNgYsuVo3djg9T
         p129olMYzYhdNlLS+IF3kzykwKNq6IzefC30tgj7KVEOoCecA0rhkyaBq4Ag4g8iTktH
         lwNMiiBI6w6CJ+sdX7pj5lTqdQpdJjKqXfG/MNEQzIiGzRNWqaxGUgy96pyubjoSIQZQ
         5ErqHTJZ1m7bmKL/g2DR6qdixV1Jdh+NV/exMNZ6bFnkTSX5KUoZQbqHuF3cuGUvOSg8
         ej0Q==
X-Gm-Message-State: ACrzQf337Uy1AwU7M7F2P/eXVmn2HmWQYCHYiwBl6N3Xe0gbajFHp3Vb
        Cgs07bVrdJga4z/+m2MauR2Z6w==
X-Google-Smtp-Source: AMsMyM5g6041duagWXSq4ZLQGnXcqgrjcCpSN7o0m9PhHoi07/8ONF/gpRG29fW+wheHBi3r4stG2w==
X-Received: by 2002:a17:902:b20a:b0:178:6f5b:f903 with SMTP id t10-20020a170902b20a00b001786f5bf903mr27366200plr.39.1665526954109;
        Tue, 11 Oct 2022 15:22:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a054900b0020adf65cebbsm86406pjf.8.2022.10.11.15.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:22:33 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:22:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paramjit Oberoi <pso@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/1] pstore/ram: Ensure stable pmsg address with per-CPU
 ftrace buffers
Message-ID: <202210111521.B8D8156490@keescook>
References: <20221011183630.3113666-1-pso@chromium.org>
 <20221011113511.1.I1cf52674cd85d07b300fe3fff3ad6ce830304bb6@changeid>
 <202210111209.7F1541F5BE@keescook>
 <CAHqLn7Hd6KaNYA=goS7=dumrG3wZedbV1+ANa+-dZzFPiP_vsQ@mail.gmail.com>
 <202210111302.3179DB77@keescook>
 <CAHqLn7EG=iKmu1tMJ_Um4MmpLVztshfzACnrzcZqPvvcRRCKuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqLn7EG=iKmu1tMJ_Um4MmpLVztshfzACnrzcZqPvvcRRCKuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:44:54PM -0700, Paramjit Oberoi wrote:
> > > The only downside is it would break some code that works today because
> it
> > > ran in contexts where the pmsg address was stable (no per-cpu ftrace
> > > buffers, or power-of-two CPUs).
> >
> > I don't follow? And actually, I wonder about the original patch now --
> > nothing should care about the actual addresses. Everything should be
> > coming out of the pstore filesystem.
> 
> We are running VMs with the pstore RAM mapped to a file, and using some
> tools outside the VM to read/manipulate the pstore after VM shutdown.

Ah-ha! Interesting. Well, I think it will be more stable this way even
for that. :)

-- 
Kees Cook
