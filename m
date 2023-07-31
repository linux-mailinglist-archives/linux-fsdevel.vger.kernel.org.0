Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC94768EA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGaHZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGaHY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:24:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480C46AF;
        Mon, 31 Jul 2023 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rHShcEcM2u09ko0JD4103oAp1nkeP+6qTIMhwFWdmLU=; b=cGoIfTm1FoKWqYkMl3aouUJzRp
        apPokR9yLK+7B96iP8eHnsJMbQknQoYVuvwpLqZq1EmeKlnCy9ovuH69oIvPnNh2hvOS9wmmxl+Fy
        ueG87unRjShkXxxKDg0B1PmSOdV/BaMTBXuPuXAvv/I6cWMbIgfsViTOz5reWnaRHWyWxL+17HzcB
        CbRt1xzabfWidNDF2arpHWNW6MY4QMxgPB/UPEU+g1HO8tEakt4n8KYgjk4KjHP813bQAsYMLoCNh
        p4CKTRrBP009EALnmFXls5Qo38I16sYBE0PmQsSOOZuIHiQILYkn/q0HTeBQqhegMtSq2M0ZteA1V
        1q0wM1bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQNCn-00EIjp-0N;
        Mon, 31 Jul 2023 07:20:37 +0000
Date:   Mon, 31 Jul 2023 00:20:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Harry Pan <harry.pan@intel.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: ksys_sync_helper
Message-ID: <ZMdgxYPPRYFipu1e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guys,

why did b5dee3130bb4014 add a magic export for sync functionality
that wrapps VFS code in a weird way, and then exports it (without
even adding a user in that commit)?   This kind of functionality
needs to be exported from the VFS, and only with ACKs?  With this
and commit d5ea093eebf022e now we end up with a random driver (amdgpu)
syncing all file systems for absolutely no good reason.
