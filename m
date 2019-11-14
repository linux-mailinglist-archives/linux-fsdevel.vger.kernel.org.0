Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CDAFC9A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfKNPPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 10:15:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34648 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:15:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id b72so5307428edf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gtZ4L4OnXWctKGxBd+LLBJKaQomtHm3z8z3VMpIKbjc=;
        b=nlbe7MkC80QZ6YdoGW7Ud8HIlKW1yn1z2kVObsLrAPlw0TFgoxpRpIbR6QYNxqjN23
         V0nipdq2rz5/Mwaje3fO1yXDjRFGnCR/K8uaqEuYMrcayFZlmpMWrTRlGAZmBeooaEON
         IHvtvu1e78yXGXJ886HSfkK5NbbQzKwftTNfiq6d3OEMAJyqBdx3ZS/QitbEWrWOlQyq
         KPKJdIPZp3VBBnrOf48S8Tg34uIlUGqa3XsgMuMg6Uh5blfmdQEtI2nnQaSmIuw+TnDd
         wPlQffm3UjP6vlZq5Q69Xe/OUDki0pRvDndLPC/iwNA6clONv3nIPXQmELKaXvbOacIS
         kvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtZ4L4OnXWctKGxBd+LLBJKaQomtHm3z8z3VMpIKbjc=;
        b=BIAa45IPVc0dlbY7HRPSy8xH1hiMKjZsiKDlVmYazoEGr3DKWEhYlP/tP4Kz+t136J
         iQjrWDFLQ68defqAJ5eKMRUqDN5icQJYqfZV46bsgBWDCu+IK/zDDd7Es44Q+ppBqa5o
         xFLR2DiargwBGR0b/lMI+/mpzuCnSgS7rsx3FBza48EUsrqsbBIwmppBxkuqKTyZM8UP
         byu43FXUJINAgfhvcuL1nxb5bQtmCIKpFdrbG/70Muc3k1Xu3xZS3yYQ+grytNvFUV1G
         JPmE5OHAFAeN+GAdwjQ2XRSZWJwvV9YKUnMkPiSjMNkJNn9g76nxfZBditWAnnwt7VjB
         khkA==
X-Gm-Message-State: APjAAAVTeZWIYJEsrl75QIKubdS9vgWKoFdpa5TCPfKS9DrHhx7NpJ6l
        qn+uXm6dc8+e1KzqfJbNXQgxIq+SnW0=
X-Google-Smtp-Source: APXvYqzk+47pB3b7G42oybHOccEF1VLxhMii3vLTXEN4wy4WvBhJYA+iQrwoIZih9bkdbuB9CN5VhQ==
X-Received: by 2002:aa7:c39a:: with SMTP id k26mr1830487edq.128.1573744537503;
        Thu, 14 Nov 2019 07:15:37 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id u30sm398494edl.30.2019.11.14.07.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:15:36 -0800 (PST)
Subject: Re: [PATCH 11/16] zuf: Write/Read implementation
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "Manole, Sagi" <Sagi.Manole@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <20190926020725.19601-12-boazh@netapp.com>
 <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <46507231-91ba-0597-94f8-48f00da46077@plexistor.com>
Date:   Thu, 14 Nov 2019 17:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/10/2019 22:08, Schumaker, Anna wrote:
> Hi Boaz,
> 
> On Thu, 2019-09-26 at 05:07 +0300, Boaz Harrosh wrote:
>> zufs Has two ways to do IO.
<>
>> +static int rw_overflow_handler(struct zuf_dispatch_op *zdo, void *arg,
>> +                              ulong max_bytes)
>> +{
>> +       struct zufs_ioc_IO *io = container_of(zdo->hdr, typeof(*io), hdr);

This one is setting the typed pointer @io to be the same of what @zdo->hdr is

>> +       struct zufs_ioc_IO *io_user = arg;
>> +       int err;
>> +
>> +       *io = *io_user;

This one is deep copying the full size structure pointed to by io_user
to the space pointed to by io. (same as zdo->hdr)

Same as memcpy(io, io_user, sizeof(*io))

> 
> It looks like you're setting *io using the container_of() macro a few lines above, and then
> overwriting it here without ever using it. Can you remove one of these to make it clearer which
> one you meant to use?
> 

These are not redundant its the confusing C thing where declarations
of pointers + assignment means the pointer and not the content.

This code is correct

>> +
>> +       err = _ioc_bounds_check(&io->ziom, &io_user->ziom, arg + max_bytes);
>> +       if (unlikely(err))
>> +               return err;
>> +
>> +       if ((io->hdr.err == -EZUFS_RETRY) &&
>> +           io->ziom.iom_n && _zufs_iom_pop(io->iom_e)) {
>> +
>> +               zuf_dbg_rw(
>> +                       "[%s]zuf_iom_execute_sync(%d) max=0x%lx iom_e[%d] => %d\n",
>> +                       zuf_op_name(io->hdr.operation), io->ziom.iom_n,
>> +                       max_bytes, _zufs_iom_opt_type(io_user->iom_e),
>> +                       io->hdr.err);
>> +
>> +               io->hdr.err = zuf_iom_execute_sync(zdo->sb, zdo->inode,
>> +                                                  io_user->iom_e,
>> +                                                  io->ziom.iom_n);
>> +               return EZUF_RETRY_DONE;
>> +       }


<>

>> +static ssize_t _IO_gm(struct zuf_sb_info *sbi, struct inode *inode,
>> +                     ulong *on_stack, uint max_on_stack,
>> +                     struct iov_iter *ii, struct kiocb *kiocb,
>> +                     struct file_ra_state *ra, uint rw)
>> +{
>> +       ssize_t size = 0;
>> +       ssize_t ret = 0;
>> +       enum big_alloc_type bat;
>> +       ulong *bns;
>> +       uint max_bns = min_t(uint,
>> +               md_o2p_up(iov_iter_count(ii) + (kiocb->ki_pos & ~PAGE_MASK)),
>> +               ZUS_API_MAP_MAX_PAGES);
>> +
>> +       bns = big_alloc(max_bns * sizeof(ulong), max_on_stack, on_stack,
>> +                       GFP_NOFS, &bat);
>> +       if (unlikely(!bns)) {
>> +               zuf_err("life was more simple on the stack max_bns=%d\n",
>> +                       max_bns);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       while (iov_iter_count(ii)) {
>> +               ret = _IO_gm_inner(sbi, inode, bns, max_bns, ii, ra,
>> +                                  kiocb->ki_pos, rw);
>> +               if (unlikely(ret < 0))
>> +                       break;
>> +
>> +               kiocb->ki_pos += ret;
>> +               size += ret;
>> +       }
>> +
>> +       big_free(bns, bat);
>> +
>> +       return size ?: ret;
> 
> It looks like you're returning "ret" if the ternary evaluates to false, but it's not clear to
> me what is returned if it evaluates to true. It's possible it's okay, but I just don't know
> enough about how ternaries work in this case.
> 

Yes Thanks, Will fix. Not suppose to use this in the Kernel.

>> +}
>> +
<>
>> +int zuf_iom_execute_sync(struct super_block *sb, struct inode *inode,
>> +                        __u64 *iom_e_user, uint iom_n)
>> +{
>> +       struct zuf_sb_info *sbi = SBI(sb);
>> +       struct t2_io_state rd_tis = {};
>> +       struct t2_io_state wr_tis = {};
>> +       struct _iom_exec_info iei = {};
>> +       int err, err_r, err_w;
>> +
>> +       t2_io_begin(sbi->md, READ, NULL, 0, -1, &rd_tis);
>> +       t2_io_begin(sbi->md, WRITE, NULL, 0, -1, &wr_tis);
>> +
>> +       iei.sb = sb;
>> +       iei.inode = inode;
>> +       iei.rd_tis = &rd_tis;
>> +       iei.wr_tis = &wr_tis;
>> +       iei.iom_e = iom_e_user;
>> +       iei.iom_n = iom_n;
>> +       iei.print = 0;
>> +
>> +       err = _iom_execute_inline(&iei);
>> +
>> +       err_r = t2_io_end(&rd_tis, true);
>> +       err_w = t2_io_end(&wr_tis, true);
>> +
>> +       /* TODO: not sure if OK when _iom_execute return with -ENOMEM
>> +        * In such a case, we might be better of skiping t2_io_ends.
>> +        */
>> +       return err ?: (err_r ?: err_w);
> 
> Same question here. 
> 
> Thanks,
> Anna
> 

Yes Will fix

Thanks Anna
Can I put Reviewed-by on this patch?

>> +}

Much obliged
Boaz
