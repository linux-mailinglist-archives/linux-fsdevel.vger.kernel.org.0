Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31B7A660D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjISOAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjISOAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:00:48 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE371A3;
        Tue, 19 Sep 2023 07:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695132024; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FZqTG4VYfgqkTH5611jzV7y9J8uOJ9/0MrVA0K+SLhf62J5l4/kuOcVgjkvrdJ+mQ0+2AatQjFuun/usAKvus3o6D0f+eG8i5Zb6pPJRCkSMd8AnIHCqzZ/w818TjiwqY6y5wT67H6TFezh/vxksfJsYxy0+PLHYZWTSdF8YPcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695132024; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=0IAP0s+RT7GZFRPLNdV3G0ElvDn5rBd3toR6u/oZ7UE=; 
        b=YUxdrO97nKa7lB3RSUn65Ycwn3gYHoPaArILgUEAUG3PgC526AM1GeJmUfv2Sv2AhU7jDEBs3aqKNkM4D3mYDnZM6walco3bz6B7jHbBneea21nDcyJ+vL604nTh3IKiRtFWUI+j4SiFvGxfcZvt8cT/lDrm0TeVJ2RRJGt3I7Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695132024;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=0IAP0s+RT7GZFRPLNdV3G0ElvDn5rBd3toR6u/oZ7UE=;
        b=NCIO2ubKx5x0uiMOVQpC9iTwOZGoOAk+fZSDM755d2dNXl53qqCiQRp4gBpuYm7+
        N517mTJuj+0AAgH0Q6Jn5KUZQehiLOJEasqaDhY9uBT93ytCpTQL+MJVcEx14aUPj1X
        +YP+iX0mK5xNenRNIVljCB4Eo7xbiyRdpIVsZ5Xo=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695132022954320.1355663481704; Tue, 19 Sep 2023 07:00:22 -0700 (PDT)
Date:   Tue, 19 Sep 2023 11:00:32 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
Cc:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
Message-ID: <rxoippwvqkrtspegmgujhceebhatfowhoce2oqaagdlen2opv2@g7gl5mypcsea>
References: <000000000000e534bb0604959011@google.com>
 <00000000000012f99f06058fc5fa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000012f99f06058fc5fa@google.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20230919
