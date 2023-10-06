Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1207BBE79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjJFSMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFSMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:12:51 -0400
Received: from a11-16.smtp-out.amazonses.com (a11-16.smtp-out.amazonses.com [54.240.11.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63DDB6
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1696615966;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=bcfVtUicGxNdh++noVu37FQQYR+APERjypmbkszOIME=;
        b=KeDxdCYTCLYXOl1wbbz5SYXxw7VQHqZw59y2Dv/YptaAnpIm4DJL6bP8gCu21fd+
        dqviia0+5IIXIp/dIXi5Asoz59dXjutzY+5D1eLgE6Lk+Az03rikLxP+xIMhigkADqm
        o1EUDH3Mq9fIFtNYBU4w4dGpyVJP9Yp/GatdxFFQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1696615966;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=bcfVtUicGxNdh++noVu37FQQYR+APERjypmbkszOIME=;
        b=K3TOH59YDp1N6mzQAqJSXfJh1Zpqgd2/CWLbwnvxVyBuKEypdz4bBAWpBAN373TY
        tk5XmYjxOYKQw5MoDNC5cyvjPjd3/TTy1ZXsxSCkfoLcyrLAF3ktP8VVGJN77i9A0It
        y3ttID6n1wPX8NTniLYmD8mTokb4qaZYfP5lgM/k=
Subject: Question about fuse dax support
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= 
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?jgroves=40micron=2Ecom?= <jgroves@micron.com>,
        =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Date:   Fri, 6 Oct 2023 18:12:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <nx43owwj2x46rfidyi7iziv2dbw3licpjn24ff5sv76nuoe3dt@seenck6dhbz7>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZ+IC0O72aZ+HeRa6RJwxZy8QIbw==
Thread-Topic: Question about fuse dax support
X-Wm-Sent-Timestamp: 1696615965
Message-ID: <0100018b0631277b-799ea048-5215-4993-a327-65f1b50fb169-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.10.06-54.240.11.16
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see that there is some limited support for dax mapping of fuse files, b=
ut=20=0D=0Ait seems to be specifically for virtiofs. I admit I barely und=
erstand that=20=0D=0Ause case, but there is another fuse/dax use case tha=
t I=E2=80=99d like to explore.=20=0D=0AI would appreciate feedback on thi=
s, including pointers to RTFM material,=20=0D=0Aetc.=0D=0A=0D=0AI=E2=80=99=
m interested in creating a file system interface to fabric-attached share=
d=20=0D=0Amemory (cxl). Think of a fuse file system that receives metadat=
a (how MD is=20=0D=0Adistributed is orthogonal) and instantiates files th=
at are backed by dax=20=0D=0Amemory (S_DAX files), such that the same =E2=
=80=98data sets=E2=80=99 can be visible as=20=0D=0Ammap-able files on mor=
e than one server. I=E2=80=99d like feedback as to whether=20=0D=0Athis i=
s (or could be) doable via fuse.=0D=0A=0D=0AHere is the main rub though. =
For this to perform adequately, I don=E2=80=99t think=20=0D=0Ait would be=
 acceptable for each fault to call up to user space to resolve=20=0D=0Ath=
e dax device & offset. So the kernel side of fuse would need to cache a=20=
=0D=0Adax extent list for each file to TLB/page-table misses.=0D=0A=0D=0A=
I would appreciate any questions, pointers or feedback.=0D=0A=0D=0AThanks=
,=0D=0AJohn Groves=0D=0AMicron=0D=0A=0D=0A
