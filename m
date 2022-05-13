Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363A5259D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 04:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376627AbiEMC4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 22:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376621AbiEMC4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 22:56:52 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56202ED74
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 19:56:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kj8so5804361qvb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=YfSyf8u/NtA/eLp0tCJ7Xe0+tnTmVim4H2pL0vEsIiU=;
        b=0mtoDTP0h+78pMTFKFTp5W2xjK1hcv0lNhcN1E0ldAU+KruS88+d+eKT2j8jX6aaTf
         xAxUnsQAhUijY/zcRao1hzMIrncEkUQ7nqKG5CKm/fhS0lLzQPWv03XD05t+jSF3w6Fp
         n4j1+9tNGrnptsTapwM26mibHHeRH17d1wRomMrwpfe2j7TM/ooGkiFYVV+0K/umc9wB
         iESWL4SXlQ0yjffaoKRY7NnCK6mRZdwVxtpBjlzXR2ZLXnLe8Y0U7R78A/K8FtX1L+vo
         fD8Dz1+4qi03W5jcPkFTNU5uJuLkxQcOfBS2F1Axp3kuB4kReBr4cLOPA+EUDC4RKVV0
         25kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=YfSyf8u/NtA/eLp0tCJ7Xe0+tnTmVim4H2pL0vEsIiU=;
        b=Ti36DHaGT0AUYwjC8ywCoy6YLQUBNdvHm34Ev3kwlprhepCWUraKNnxZA8x9ghzTGr
         5FwWN4drrcWcgdEHVCRNFqJ5IGseX6cS/O6diJxNmSADiBMEZIxhEc/aZs+tfXdzMS26
         Jurs7NBNNhrUbIWZKupcL3St1qz5axqyVkqcPuKOP3ZcmYhNKZmIZedlmD0IpNoi/CIU
         HGhyxP3LCEGWKTXV5xSvYBP/CoQVk92CjQdvYNEt+0lQvA38x5bJdzrXtAT119+tw0hE
         YmJPIZECIA3ZykT8oHGsb2yBgN6ehsRKc3O0lP4If9w0CjHkN44b7A/MRUi0QUYmfsTl
         PiPQ==
X-Gm-Message-State: AOAM530/YIcZNon66y9BQDrCGExUm1dnypnrMEnVksLc6aUV7qvKP+A6
        9w1MRIA7BL2lAOGn8BI0lH3wktJnQz26dQ==
X-Google-Smtp-Source: ABdhPJwEkF4mdxyhyJw1VUq1yi0cunHOiqDqtKhsTWuDuqm6cZSOXpnjZ7qhYCMJiPw/3cavmMdKaw==
X-Received: by 2002:a05:6214:2aae:b0:45b:3d6e:e6e6 with SMTP id js14-20020a0562142aae00b0045b3d6ee6e6mr2865442qvb.111.1652410606448;
        Thu, 12 May 2022 19:56:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a208100b0069fc13ce205sm686031qka.54.2022.05.12.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 19:56:45 -0700 (PDT)
Date:   Thu, 12 May 2022 22:56:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, bpf@vger.kernel.org,
        lsf-pc@lists.linuxfoundation.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF 2022: Slides and thanks!
Message-ID: <Yn3I7KZeuJQqVFHi@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Thank all of the participants of this years LSF/MM/BPF! It was great to finally
get together as a community, both in person and virtually.

If you presented this year and had slides please email the slides to
lsf-pc@lists.linuxfoundation.org so we can attach it to the videos when the
recordings are uploaded to YouTube. We will also forward these along to the
staff at LWN.

If any of you have objections to your sessions being posted on YouTube please
email the lsf-pc list so we can make sure to exclude those videos.  We already
have a couple of requests, so if you've already made one you don't need to let
us know, we already have it marked down.

Thanks again for a great conference!

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)

