Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B832C2EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbgKXRik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403892AbgKXRik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:38:40 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AAC0613D6;
        Tue, 24 Nov 2020 09:38:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so5156192qki.11;
        Tue, 24 Nov 2020 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4LY6zleEye3uEtWn8BHkQWiPOUg2vGvLOmcGW0MhEo=;
        b=b7LkmYjxPrHR9TH3nlGv8RR4yt2n5LXnfymO+2DyzzU25nyOq3KZcwcvGjHXs52rxS
         +2ZXS0GcpcERn/nD7GKubAB3+B2PcUxizzfKAr8S2K2+IhWzgsJmU4g5HL09fBRhhrfd
         O9DxlLMUUmPA8UQ1XMZvrQyWKKdOK7UwZVw5EW2mNWCI7GBjN/XmPhbk3TYX7y+MWxjO
         swjqQPApTPanWu4qovGXQq//Y6ENdGy9PdgI17eJIoJsi/+bV6r0YDHFS6xz5gpMJ5IK
         uIvwIkKQlKgUDmgdCif0kTpOaJ/NZcVJOzZhxhpZTTstgSJmyH2+hiJsrfoAgMEwi33G
         0McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g4LY6zleEye3uEtWn8BHkQWiPOUg2vGvLOmcGW0MhEo=;
        b=M5dWHfdRZbGIJ66LWDI0tUgbNWfucSaAJyAOC7Pc2kaR6EwwEdXan29giwaOu2k65n
         zcHCz9A7xtxjL8rxa2uY9z2oB/+Ngrzrm68olS+2RI2stkkAyaFLClwC2LIPOuswLOkd
         JJNCHzoMn7jJN32vLmuEqWarScBLUYynfw02JEizexP7xs2Oh0fGqmnsoTc4HZY1YnKf
         WwxksVioPq615M4JI0OYJs2BkSKlJXAKeFAJpBDZcM/cHQPQznFUF0TyPXciPSeZ1Pk7
         IQ+qJE6/DiH53b+vTQ9/3bpK7lN44autJV4TgKqJ4z1Rhgo0gbNYuvQ/haMKfWnEWja5
         JczA==
X-Gm-Message-State: AOAM531oPBzkniWYlOkH7gi+EyeYBbtXpoqmO2GOJT8rj65Vyl9zlv1R
        9x47w8j4LgVmwidnZaMH9GU=
X-Google-Smtp-Source: ABdhPJw43+aOSAPykQeYdeX4DmgWRqK+CIO4uPy4u98lyqJL8LkKiYWD+c6leseDOSmCa64pRPr2xg==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr5925723qkf.29.1606239519064;
        Tue, 24 Nov 2020 09:38:39 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id s7sm13183950qkm.124.2020.11.24.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:38:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:38:16 -0500
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
Subject: Re: [PATCH 16/45] block: change the hash used for looking up block
 devices
Message-ID: <X71FCKpLZLywTTT8@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:22PM +0100, Christoph Hellwig wrote:
> Adding the minor to the major creates tons of pointless conflicts. Just
> use the dev_t itself, which is 32-bits and thus is guaranteed to fit
> into ino_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
