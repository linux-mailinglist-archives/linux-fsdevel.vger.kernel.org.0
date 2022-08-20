Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC859B04A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiHTUMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:12:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7B2CDD3
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bSzlm9e7hxH98KK+Z3EkaFZXFBRdpojMxa+ZQfthZOc=; b=Cg6DopRCP6yfOVkiDPOen26tfF
        VSyuwdGf64ndUNwq9XvKCresqeyDWP5cmhjhtuqEhACYtySVPa4XDRJwbUV/ArB8gCglUoUwC3Rml
        j5K8pzpAx3m8lOjJV2eHLT8Vv/7DyddTVMygODQF8BPeEoMAkrnQN7tQ8KANvtqMrBlt3lgu/zdct
        rzn627R0y/NlJ48L6rTIIKeyAO1WMLq7vZzo3AJneIgZvBCyNwWdO6s8FGhBuAvYhKAcoH20G2Uqj
        0jEo6GBE6Lio8L8E7ocAOr4lcVDzT7V9Y7zqD1hKlfTsSIsUTq/imcBqc0EQSiPAMd6nBfb5yoPJj
        kfCQlSkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUpg-006T5e-RV
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 20:12:37 +0000
Date:   Sat, 20 Aug 2022 21:12:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCHES] file_inode() and ->f_mapping cleanups
Message-ID: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Another whack-a-mole pile - open-coding file_inode()
and file->f_mapping.  All of them are independent from each
other; this stuff sits in vfs.git #work.file_inode, but
if maintainers of an affected subsystems would prefer to have
some of that in their trees - just say so.
