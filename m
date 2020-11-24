Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776E2C2F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404196AbgKXSGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 13:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKXSGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:06:15 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C83C0613D6;
        Tue, 24 Nov 2020 10:06:14 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so16710724qtb.10;
        Tue, 24 Nov 2020 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGgWvl0Napb7ckr1b5Je/XF/vo+wq/s703ULFNCgBaI=;
        b=mFcTt0MgjM9IqQp5CjNn460f80WY5TgOpPJ6Ay4ntldAJKb6Rjl0HTJIZ+yFn5diNg
         Y9XgufAijyGSVMo3oa5mbzUjsTfdGF4klUksliDQRN3qDG0d8QMDnfA4E5LuG2LRxix9
         hartKdsjUyOnRZk1OwfqKdcIsVXRFfJDauC2DAxEf1EDFmBabgsDa0m7UqLxfYY5bZRj
         zYqj7h62Xy2JH5Y5YERtz3Jqa3G8xCCNygCgwbvWWscHLpe2a2ipXU92XYpjwaNY0VJ2
         iVk3YMDEtvOraBt/erbOI6z6NYw/s24zXpCk/3X14GTWVBM8KYbSPmvWGmoSgwz5tNpw
         HXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XGgWvl0Napb7ckr1b5Je/XF/vo+wq/s703ULFNCgBaI=;
        b=GK2tzcV/cHZ0mqVmOPzSUsl/7tQ9QxNKbGS1+Jf5KxQzOLmXrldL5qwN/aSFpylvZu
         CmVbS6BADXb6gciMP/uLevpm2KgrYesNPoIBv+bwUbDevbfIf6FfWi6+eMoI4PbLA2Om
         CwrH2cyJTSf/Ux3odSoL5qjmRVTs28lWwuASpnEzfMULVXOwYcwhG3Uq+8SvtrLq6mQ6
         dmJdWofWRlG4mkioV75CZR37wcJYgkDB8Vi52CAmS5Bjfdtl/b/fPOPOYa+W5J/xOQaU
         FcHuIUbiOMrllwGHPZSKkhuDXbXc8mRcd9N3c0pFw8iC7h/615oSuP+ZusNyTdgO6vMi
         gF0g==
X-Gm-Message-State: AOAM533045rvbrZpQkzrEc+TE+mhmzdSh4XFaLRGq31bX4RA/vBhBvuH
        q5eaT7/Xe61704mTEJ9Lqp0=
X-Google-Smtp-Source: ABdhPJy4KzGqVN9OifimW7Bbj0BtBOYaib7uEK7t2ko3uV9boQAgproJwZycxdIrJmhhR00FFdaCLQ==
X-Received: by 2002:ac8:58c7:: with SMTP id u7mr5558192qta.54.1606241173470;
        Tue, 24 Nov 2020 10:06:13 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id s7sm13264706qkm.124.2020.11.24.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:06:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 13:05:50 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 22/45] block: opencode devcgroup_inode_permission
Message-ID: <X71LfgUr2lIKqDx+@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-23-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:28PM +0100, Christoph Hellwig wrote:
> Just call devcgroup_check_permission to avoid various superflous checks
> and a double conversion of the access flags.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
