Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33004736EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjFTOgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFTOga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:36:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FE1709;
        Tue, 20 Jun 2023 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E6LUAGD2W9fniJVMeYXWWaWOxjcy8tolmVGdHxej/T4=; b=RYOS+Mf9ZwkRDYzJNRld1VlcV5
        rmAj1dKJ1nFSqFYRaLed5du+1YGpRP3Gs0L1Uq9s8TVJbJFj58Q0u6yAbYBBGhow0Z6/lbRVHDJyK
        M0j1LbliacRMsUQ5NMrTRytiXGTMBMPeSXJFq22Nu5n7O278WJCAp/tFLBuizg0LkM2lSjZw5sVR8
        tL2PGtC4PJ1I2tBa0hNCVYRYvc5pa8Ldd0FPTOWGRVeodjtLM7dHBF4wLurTT3SBzSwsgOU9ye2+9
        0YvqME3Nz9FG/1QYtnkfeLS2l3MqSJ0yLSeDBL0mClGRZjrqhXWOZObsRZVs8SlNQ7ZFeTJyCYW51
        0uCjzr1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBcSy-00DBum-Oq; Tue, 20 Jun 2023 14:36:20 +0000
Date:   Tue, 20 Jun 2023 15:36:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     stsp <stsp2@yandex.ru>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Message-ID: <ZJG5ZOK8HKl/eWmM@casper.infradead.org>
References: <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
 <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
 <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <ZJGtmrej8LraEsjj@casper.infradead.org>
 <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 06:47:31PM +0500, stsp wrote:
> 
> 20.06.2023 18:46, Matthew Wilcox пишет:
> > On Tue, Jun 20, 2023 at 06:39:07PM +0500, stsp wrote:
> > > Though it will, for sure, represent the
> > > task that _owns_ the lock.
> > No, it *DOESN'T*.  I can open a file, SCM_RIGHTS pass it to another task
> > and then exit.  Now the only owner of that lock is the recipient ...
> Won't I get the recipient's pid in an
> l_pid then?

You snipped the part where I pointed out that at times there can be
_no_ task that owns it.  open a fd, set the lock, pass the fd to another
task, exit.  until that task calls recvmsg(), no task owns it.

