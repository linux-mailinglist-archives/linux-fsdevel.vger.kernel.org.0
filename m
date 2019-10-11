Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82900D47A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfJKScx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 14:32:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfJKScx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KuZJTKexqaq6N8+Arnw3Gzlw8FJrb4wzaEcsNhnrBek=; b=Mi8AOjGSSUR3IwzHRpYu3qJoy
        bdnAOZQqFKxzKU4Jb796ruU+k/Y+EPHUMp3JS4Md3dOQa79JNPgmozBLtaTAh1WpsTcuVVMiDjZEs
        W/yeqxja+GYVjBGBuBijkvyCBpoB5xBkvTBzpKqRxNs0bJWrvHwCx9wIbnqfY+xJaaHfBDyy6gAEN
        QBG/25Tr0ikT+D1YuIRCSDE8fuc/GLpit/jMJpMg2lrBesohJO+VJVopOToosTueYmkDCswFQRHD+
        oo1DLlj2QLO8oaNZx1Z0ZamZB/BnFffv67EqvzXj7EmrdzZSuH02WndLamotGhEtBs9F2He3XJN6t
        9aDaTv5Gw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIzif-0004v2-3V; Fri, 11 Oct 2019 18:32:53 +0000
Date:   Fri, 11 Oct 2019 11:32:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191011183253.GV32665@bombadil.infradead.org>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
> @@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		list_add(&inode->i_lru, &dispose);
> +
> +		if (need_resched()) {
> +			spin_unlock(&sb->s_inode_list_lock);
> +			cond_resched();
> +			dispose_list(&dispose);
> +			goto again;
> +		}
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  

Is this equivalent to:

+		cond_resched_lock(&sb->s_inode_list_lock));

or is disposing of the list a crucial part here?

