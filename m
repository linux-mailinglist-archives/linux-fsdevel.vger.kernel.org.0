Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8929A230CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgG1OuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:50:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730335AbgG1OuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595947822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWjykGqBMInyrV21RjBwz09v26RfChOpFP7bkHaZWz0=;
        b=fVur65Vd4pvAnkpPRYn8FI+r2NpHmxN3Gzz7hJIvLjCeVjBXxzVrQlmQPLW8MMI+vKUvpW
        nTEwSoIMSLU5c/g0DFBWohPKNIY94SQ4GxSYTQ/+M6srSlnsl8YaOKcpiVnQbxdKex+JIx
        kwhjo4o6RnZyLMjKXJBCmiuP07Y20JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Zrerl_7zO_amUtxi0bg-EA-1; Tue, 28 Jul 2020 10:50:20 -0400
X-MC-Unique: Zrerl_7zO_amUtxi0bg-EA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31BB6193F560;
        Tue, 28 Jul 2020 14:50:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.181])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE9C069324;
        Tue, 28 Jul 2020 14:50:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jul 2020 16:50:17 +0200 (CEST)
Date:   Tue, 28 Jul 2020 16:50:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 1/4] [RFC] fs/trampfd: Implement the trampoline file
 descriptor API
Message-ID: <20200728145013.GA9972@redhat.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200728131050.24443-2-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728131050.24443-2-madvenka@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/28, madvenka@linux.microsoft.com wrote:
>
> +bool is_trampfd_vma(struct vm_area_struct *vma)
> +{
> +	struct file	*file = vma->vm_file;
> +
> +	if (!file)
> +		return false;
> +	return !strcmp(file->f_path.dentry->d_name.name, trampfd_name);

Hmm, this looks obviously wrong or I am totally confused. A user can
create a file named "[trampfd]", mmap it, and fool trampfd_fault() ?

Why not

	return file->f_op == trampfd_fops;

?

> +EXPORT_SYMBOL_GPL(is_trampfd_vma);

why is it exported?

Oleg.

