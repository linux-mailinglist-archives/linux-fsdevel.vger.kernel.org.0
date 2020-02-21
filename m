Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2099D1684FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgBURbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:31:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBURbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pDx3LdN9kmcpyyosCuGFps+kdXETL/vBLPKf49LLrtA=; b=WC40/Nnwv876skL3b390tcpGP9
        HgE+oXYuSaMQgz5W07wW6Rr47DqxNlyAwrKb3/uPmOsWKnNnVtYE8Xz8DSZGJ3C99Qd3sG6xfF9Ii
        XuBMvXiTK1amcjIiiq2kC4rs8ffrhGi/JO8Nwy+/88DvBOdifqDnueyctDpfPXJkr2EnAO3y6bwzj
        3Y/4M719cDTpkqdmkX6WdGI/x1/3C/oubQQKuEl2mpHoXbl/1syPu+YXJIUiGA/PikgQ4hmyESHN5
        9PXCOS8FkY3cPGe3AZJ4n/D8zsxqyOfQG7Y2RkV342MYTYvMNg5nastL2NES3sKMkOr41xuj8BRQJ
        POSqE2XA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5C90-0001Qd-83; Fri, 21 Feb 2020 17:31:18 +0000
Date:   Fri, 21 Feb 2020 09:31:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20200221173118.GA30670@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-2-satyat@google.com>
 <20200221170434.GA438@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221170434.GA438@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:04:34AM -0800, Christoph Hellwig wrote:
> Given that blk_ksm_get_slot_for_key returns a signed keyslot that
> can return errors, and the only callers stores it in a signed variable
> I think this function should take a signed slot as well, and the check
> for a non-negative slot should be moved here from the only caller.

Actually looking over the code again I think it might be better to
return only the error code (and that might actually be a blk_status_t),
and then use an argument to return a pointer to the actual struct
keyslot.  That gives us much easier to understand code and better
type safety.
