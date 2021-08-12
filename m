Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E881C3EA41F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhHLL4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 07:56:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhHLL4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:56:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77A7D22201;
        Thu, 12 Aug 2021 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628769384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/GPY4+bapPOd1ChiVHOPE1vdPBIG+lFx1zYMMhhGLc=;
        b=f+WYP7PFYMC/dl/+RJ0fTYpSqBVqngL0S1o8IWPwpEzsBmK+BiGh/mC9VP+KsPPgKLfJgD
        uZdqIhPLRLrBZ18yTah9m6BzxgsiwKI4S+sle5OgTUh75Ky3Z3szoy2121k98eCNIbLLl6
        U0B03c5rwl3SZTqPRDNSUzqLwwQN2qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628769384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/GPY4+bapPOd1ChiVHOPE1vdPBIG+lFx1zYMMhhGLc=;
        b=Dq4VDVt1Ac6dV6iTN8VeZ2Kop/ALi3KiMr4y/diLRrzvcL9rkfDM/6TkI2Co6f22Y55Xdt
        oAJESFNXwfhfqhCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 626F313A90;
        Thu, 12 Aug 2021 11:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xVpPF2gMFWHAPQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 11:56:24 +0000
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b9c3038a-56af-95e9-b5dd-8e88f508719e@suse.cz>
Date:   Thu, 12 Aug 2021 13:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-63-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of migrate_page_copy(), which is retained
> as a wrapper for filesystems which are not yet converted to folios.
> Also convert copy_huge_page() to folio_copy().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

The way folio_copy() avoids cond_resched() for single page would IMHO deserve a
comment though, so it's not buried only in this thread.
