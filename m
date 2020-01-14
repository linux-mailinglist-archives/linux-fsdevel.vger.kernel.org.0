Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23B13B233
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgANSdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:33:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgANSdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579026823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU3iLjKmaQ0aNJQ9ZbgSwibwLQ11TCA8buR9ZQY0R+A=;
        b=UtHq2sW4cdTFh1NyvPX7PwJvumIv8lApltMFT3/dT3R0ezQE3xJnMYrJjIvhsV9Q0B6KaS
        cr+Ck+c/IpueQnm4Q9VpoPpaCG2LnjI7ev1/wyjaZZ7o4pz84xIxHIWNBYJWXAhwfjFhNr
        V+uZ6cmlcJxqAK0HDmyGjRdMMI24J7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-OMK7ZWSpPBGwRivqNqoE-g-1; Tue, 14 Jan 2020 13:33:40 -0500
X-MC-Unique: OMK7ZWSpPBGwRivqNqoE-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD03F801E78;
        Tue, 14 Jan 2020 18:33:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-218.rdu2.redhat.com [10.10.122.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8900F5C1D6;
        Tue, 14 Jan 2020 18:33:33 +0000 (UTC)
Subject: Re: [PATCH 02/12] locking/rwsem: Exit early when held by an anonymous
 owner
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200114161225.309792-1-hch@lst.de>
 <20200114161225.309792-3-hch@lst.de>
 <925d1343-670e-8f92-0e73-6e9cee0d3ffb@redhat.com>
 <20200114182514.GA9949@lst.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <478b3737-79e1-33a9-ac44-c6656e83adf5@redhat.com>
Date:   Tue, 14 Jan 2020 13:33:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114182514.GA9949@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/14/20 1:25 PM, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 01:17:45PM -0500, Waiman Long wrote:
>> The owner field is just a pointer to the task structure with the lower 3
>> bits served as flag bits. Setting owner to RWSEM_OWNER_UNKNOWN (-2) will
>> stop optimistic spinning. So under what condition did the crash happen?
> When running xfstests with all patches in this series except for this
> one, IIRC in generic/114.

OK, I think I know where the bug is. I will send a patch to fix that.

Thanks,
Longman


