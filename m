Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95265D7521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfJOLfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 07:35:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfJOLfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zPxLUku4BuRDt5+SJLEWDEFub4QOmiwDKS+8qep8Bak=; b=ZHcs9NvGWGV7QE24aroVDMFzT
        enbdNKTsTAoSDcwBixZFb4uNCsCnqIbv1+8tmPSVDwWFaJEeL/UR0qAqdTaKaFm2qTkRY7f/HR9fG
        5cn0JNSc2cZuOe6PU1MQ+kPr0wQnXdx8Yef0x6yStoMAQM5hmEc7++Hel1avjJPK0605o30gna1Rb
        v8ToEKIHyQ/n7YuUPgNPvDCNZ+fHM6bhkLdcQOFXQzoR6kJPontTaLYhK9ozqj7Z4tO9n9/+/ZoHY
        0yfevKwaeNoWRmiLyweSOvMbYWfkBHitiZuWxyF/APSIJI2lu2Bl4FRSvMIe6xK7V5N0l7sAaoMfZ
        PuSsGLzMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKL7F-0006DH-0D; Tue, 15 Oct 2019 11:35:49 +0000
Date:   Tue, 15 Oct 2019 04:35:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Project idea: Swap to zoned block devices
Message-ID: <20191015113548.GD32665@bombadil.infradead.org>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015043827.160444-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:38:27PM +0900, Naohiro Aota wrote:
> A zoned block device consists of a number of zones. Zones are
> eitherconventional and accepting random writes or sequential and
> requiringthat writes be issued in LBA order from each zone write
> pointerposition. For the write restriction, zoned block devices are
> notsuitable for a swap device. Disallow swapon on them.

That's unfortunate.  I wonder what it would take to make the swap code be
suitable for zoned devices.  It might even perform better on conventional
drives since swapout would be a large linear write.  Swapin would be a
fragmented, seeky set of reads, but this would seem like an excellent
university project.
