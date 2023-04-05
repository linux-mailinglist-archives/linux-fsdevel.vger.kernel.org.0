Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C916D7DD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjDENhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjDENhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:37:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE444C28
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 06:37:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7585535bd79so18329539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680701841;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMACiJoNW6UL2b8KEXrA9z4AHCYPwLvMVkZG5jbqYsU=;
        b=0SbrqR9Hi2bWm4bLG/5yE8o+jagwr5aLVKJ10+MOeHuh65tZpSboNe3YBLIJb9yRma
         6aUGVy1vXvM9WHZcuJ3OQo07NKs96I5Pu8c4KAqH+7vjm0A0eBmGar9GQDAoiEfTjjKI
         S77L3SLvhI36dkqqUyiNoPqE0OVa6SKvTXMvrb8r9IfNXxNvVRpx1Ft/If7yFlbSqLx6
         nufX8WVg0Hw9mjQl/rwT5c5W3dGWXWkGQXWLpFBUf0IdN1BJ/2CnQYHiB6usAZa8n4x2
         Ep9AWHFYMdIINBv3I1yMNN1PxKW3yZOIpxjzEIokw95DLH2rr2gTYrnnjOiKrpNoIbTy
         B/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701841;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMACiJoNW6UL2b8KEXrA9z4AHCYPwLvMVkZG5jbqYsU=;
        b=fw9qQ4jGiooZpaz9h6kmw2f2pa4vqs9oxHc0h6/vy71gvB564dTftXE26AlsHj46qw
         gGpLZv+OUJXPAoVn0jwoKJg3upUCax2EWNkGF6we/Yqf7sGFwry5OTs/gjgl9gaGyUt8
         Lx8K/RsMZ6qF/qDOSUgcZ2w4o4wt/TjhAQsqxzTbTwDAfiwhQY9n0Etm0gVC3SA46oNb
         rd+7vsPe43DOGdaM5mGPDrmnb4ZcIkKiyn9gwtE3dfOc06/bzkLyBAJ4gBgTJXHMBMFl
         qyyBvBg2ViqtY/l5H6tCO1TsERKecVsMyB0+mZy8tS7Aw2eoXRmdoRA9dTGwHdhWiG0O
         egnA==
X-Gm-Message-State: AAQBX9eOdCMnfXw05vJHNhx/wmiUJOwctmeEP/L8ewugiLqowxQXBF9F
        gdK2bRaauWykORd3wmY6g0/2Pw==
X-Google-Smtp-Source: AKy350Zi/uU7mBlI7a3mLEo2lbcBTqjpeVirj1zVYuJdxOFP0K02w1bg5MQyzg/cTnEsUTe/dc0ljQ==
X-Received: by 2002:a05:6602:3941:b0:758:9c9e:d6c6 with SMTP id bt1-20020a056602394100b007589c9ed6c6mr1788054iob.2.1680701841412;
        Wed, 05 Apr 2023 06:37:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u19-20020a02b1d3000000b0040b4ac6490dsm680489jah.96.2023.04.05.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:37:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2933618.1680689716@warthog.procyon.org.uk>
References: <2933618.1680689716@warthog.procyon.org.uk>
Subject: Re: [PATCH] iov_iter: Remove last_offset member
Message-Id: <168070184053.176456.9607242016242560793.b4-ty@kernel.dk>
Date:   Wed, 05 Apr 2023 07:37:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 05 Apr 2023 11:15:16 +0100, David Howells wrote:
> Can you add this to the block tree?
> 
> David
> 
> 

Applied, thanks!

[1/1] iov_iter: Remove last_offset member
      commit: 867e1cbba73ea240f9417439479df7eb74b1299c

Best regards,
-- 
Jens Axboe



