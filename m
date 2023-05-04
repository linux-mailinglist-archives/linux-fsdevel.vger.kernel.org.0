Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583E66F6DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjEDOjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEDOjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:39:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2F129
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 07:39:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f18335a870so4464645e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683211155; x=1685803155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQjXw3+3tov51EQCOyJwSYmtObcFNsfp4UvWHVua/dQ=;
        b=Xl7EHFCyH7jgDPfyWO/OVnKTwFyghn+e2gjzn06r/pDJTeFbeBoQI2lRes22eU6qqV
         URvQcIgWzbKeJR2cJYVbmE47+SFqy6+24WN3CCUDpPJyIv2haXFu6MZIbZwtLNUN4VEM
         tDGdKgi33OGYlUJIn3/6MwzhHTzGhPEzIkibJVoretppk9tw5mLZ5oOu/nbDJ/SdItqA
         qQ4fZpR/EdcegoBAFNij0po1/KNvX/pKZzWrfbxXd4YiIFSOIbBOFjPmnttwh5LnyJil
         XRnld/OB00E62wZnhcmsoW/3+9OPtx6M3j8bKnhsY/CG2pQfe4JFL+2o+r0/K2wsjF4Q
         f2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211155; x=1685803155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQjXw3+3tov51EQCOyJwSYmtObcFNsfp4UvWHVua/dQ=;
        b=SejwsQlabZGcVuakpChDUTrfUhY2H4cyoHeB/eSaE5U63l5CjTvQu2ez8Hh1jxOHfY
         mZft1LsPaw1iukwul64DnkkxxH3J3nJLubxgWq9rlXFB1zKjuturfz7uUpsgEy47Pwxm
         VAsFJzI9ccovZ1i46UI4wsvuB1UCn33GmLMn8mK3Ts6J3fvSrjSTke1ILKhd2NhAfYBS
         SLlFw7lSgCPB0eY9LyFcF4XI4uA/Oqbl1blcdgkx5a1SNaVLfewfjnKcykqBogSp0Jsd
         5ps9uKfgf2YnWQcVJtWs9hzkytEJlGPFh2lgmCdmyGOOLwSDmJqMZHHaGyGCMifJ3IkB
         2WEA==
X-Gm-Message-State: AC+VfDwYNDiyv+ZUijfVRedML6k9C1lxkAjUqwnDq96cSEp61cTw10Uj
        0fmwPuK2E8qlNit+P6wlH/rzZA==
X-Google-Smtp-Source: ACHHUZ4G2e4HPzg82vBpbvSDhfws5MmyXgZ1bvKEwGMfhoMqr3w1AOdCOr3WrCYJ4PVJdyjrmlFysg==
X-Received: by 2002:a05:600c:2209:b0:3f1:94fe:65e2 with SMTP id z9-20020a05600c220900b003f194fe65e2mr16937975wml.33.1683211155255;
        Thu, 04 May 2023 07:39:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm5098995wmq.26.2023.05.04.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:39:12 -0700 (PDT)
Date:   Thu, 4 May 2023 17:39:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fs: hfsplus: remove WARN_ON() from
 hfsplus_cat_{read,write}_inode()
Message-ID: <bbbb32c4-260e-4b2e-80e0-531d8be004d0@kili.mountain>
References: <6caecd65-bd3c-45d4-8bfa-f73ddc072e94@kili.mountain>
 <50928469-d4fe-881d-1c38-fed869620f37@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50928469-d4fe-881d-1c38-fed869620f37@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 08:34:27PM +0900, Tetsuo Handa wrote:
> On 2023/05/04 20:14, Dan Carpenter wrote:
> > Hello Tetsuo Handa,
> > 
> > The patch 81b21c0f0138: "fs: hfsplus: remove WARN_ON() from
> > hfsplus_cat_{read,write}_inode()" from Apr 11, 2023, leads to the
> > following Smatch static checker warning:
> > 
> > 	fs/hfsplus/inode.c:596 hfsplus_cat_write_inode()
> > 	warn: missing error code here? 'hfsplus_find_cat()' failed. 'res' = '0'
> 
> It has been returning 0 since commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
> I guess that the author of this filesystem was wondering what to do in that case.
> Since this filesystem is orphaned, I don't know whom to ask.
> If you think returning an error is better, please submit as a patch.

Returning an error is probably correct, but I can't test it.  Let's just
leave the warning until someone comes who knows for sure.

regards,
dan carpenter
