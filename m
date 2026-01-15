Return-Path: <linux-fsdevel+bounces-73894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D3D2308F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A3E3086038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406232ED43;
	Thu, 15 Jan 2026 08:11:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDC31355D;
	Thu, 15 Jan 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464711; cv=none; b=F9aK0QwEsckBaus+oAZI7VTDz3oa3crw871sjmi0S1WWf5JtFeyFurLiUVgXAbAzyqoO0YKZnpR1EKKrz3NX92EFCuGegEtbdsPgmWAFD96xikvpYQBUsGKTpyMIh888tHLG3JFcZswe7Kf0dvk3+HshZbzEiRqq5IlsUNeYzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464711; c=relaxed/simple;
	bh=LbengVoueZxA68Gorq/Vl5OkWmsg60I9iaLKoo/Faxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPPhYEC3KW8dwVRPGAJPbmI42i8GAL/hIUR0CwXk4lrdT1eU02dxU7i9MDT/mxE6Vg7avJHycRc0R3yTGWC01LWMnvSb9ooRlYoO+aEqtW31DG+9nxb5SLSoXsmorsHdmNkfdKV+5b82b/D4g3cUd6vDNMLjTu14YvN9QlqCu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 7C785E01E4;
	Thu, 15 Jan 2026 09:01:59 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 09:01:58 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v4 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aWiZyJAM0i-zc9hl@fedora>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-1-0d3b82a4666f@ddn.com>
 <CAJnrk1YGyiWLjx3FF9U4z4ARAiW93mFjsEdCVxoBGGZP3hgXAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YGyiWLjx3FF9U4z4ARAiW93mFjsEdCVxoBGGZP3hgXAg@mail.gmail.com>


Hi Joanne,

thanks for taking the time!

On Wed, Jan 14, 2026 at 06:40:59PM -0800, Joanne Koong wrote:
> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > For a FUSE_COMPOUND we add a header that contains information
> > about how many commands there are in the compound and about the
> > size of the expected result. This will make the interpretation
> > in libfuse easier, since we can preallocate the whole result.
> > Then we append the requests that belong to this compound.
> >
> > The API for the compound command has:
> >   fuse_compound_alloc()
> >   fuse_compound_add()
> >   fuse_compound_send()
> >   fuse_compound_free()
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/compound.c        | 270 ++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h          |  12 +++
> >  include/uapi/linux/fuse.h |  37 +++++++
> >  4 files changed, 320 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > +};
> > +
> > +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32 flags)
> > +{
> > +       struct fuse_compound_req *compound;
> > +
> > +       compound = kzalloc(sizeof(*compound), GFP_KERNEL);
> > +       if (!compound)
> > +               return ERR_PTR(-ENOMEM);
> 
> imo this logic is cleaner with just returning NULL here and then on
> the caller side doing
> 
>     compound = fuse_compound_alloc(fm, 0);
>     if (!compound)
>           return -ENOMEM;
> 
> instead of having to do
> 
>     if (IS_ERR(compound))
>            return PTR_ERR(compound);
> 
> and dealing with all the err_ptr/ptr_err stuff

I agree, will be fixed in the next version

> 
> > +
> > +       compound->fm = fm;
> > +       compound->compound_header.flags = flags;
> > +
> > +       return compound;
> > +}
> > +
> > +void fuse_compound_free(struct fuse_compound_req *compound)
> > +{
> > +       if (!compound)
> > +               return;
> 
> The implementation of kfree (in mm/slub.c) already has a null check
> 

I hadn't thought about this while I did the simplifications for last veriosn but
then we actually don't need fuse_compound_free() at all.
We could take that out and just use kfree() for the compound, don't we?

> > +
> > +       kfree(compound);
> > +}
> > +
> > +int fuse_compound_add(struct fuse_compound_req *compound,
> > +                     struct fuse_args *args)
> > +{
> > +       if (!compound ||
> > +           compound->compound_header.count >= FUSE_MAX_COMPOUND_OPS)
> > +               return -EINVAL;
> > +
> > +       if (args->in_pages)
> > +               return -EINVAL;
> > +
> > +       compound->op_args[compound->compound_header.count] = args;
> > +       compound->compound_header.count++;
> > +       return 0;
> > +}
> > +
> > +static void *fuse_copy_response_data(struct fuse_args *args,
> > +                                    char *response_data)
> > +{
> > +       size_t copied = 0;
> > +       int i;
> > +
> > +       for (i = 0; i < args->out_numargs; i++) {
> > +               struct fuse_arg current_arg = args->out_args[i];
> 
> struct fuse_arg *current_arg = &args->out_args[i]; instead? that would
> avoid the extra stack copy
> 
> > +               size_t arg_size;
> > +
> > +               /*
> > +                * Last argument with out_pages: copy to pages
> > +                * External payload (in the last out arg) is not supported
> > +                * at the moment
> > +                */
> > +               if (i == args->out_numargs - 1 && args->out_pages)
> > +                       return response_data;
> 
> imo this should be detected and error-ed out at the
> fuse_compound_send() layer or is there some reason we can't do that?

I have already taken this part out for the next version, since we don't have in_pages and out_pages at the moment anyway. Those can be added later when we actually use them.

> 
> > +
> > +               arg_size = current_arg.size;
> > +
> > +               if (current_arg.value && arg_size > 0) {
> 
> If this is part of the args->out_numargs tally, then I think it's
> guaranteed here that arg->value is non-NULL and arg->size > 0 (iirc,
> the only exception to this is if out_pages is set, then arg->value is
> null, but that's already protected against above).
> 
> > +                       memcpy(current_arg.value,
> > +                              (char *)response_data + copied, arg_size);
> 
> Instead of doing "response_data + copied" arithmetic and needing the
> copied variable, what about just updating the ptr as we go? i think
> that'd look cleaner
> 
> > +                       copied += arg_size;
> > +               }
> > +       }
> > +
> > +       return (char *)response_data + copied;
> 
> is this cast needed? afaict, response_data is already a char *?
> 
> > +}
> > +
> > +int fuse_compound_get_error(struct fuse_compound_req *compound, int op_idx)
> > +{
> > +       return compound->op_errors[op_idx];
> > +}
> 
> Hmm, looking at how this gets used by fuse_compound_open_getattr(), it
> seems like a more useful api is one that scans through op_errors for
> all the op indexes in the compound and returns back the first error it
> encounters; then the caller doesn't need to call
> fuse_compound_get_error() for every op index in the compound.

I think wee need both.
Imagine LOOKUP+CREATE you want to know if just the first had an error and the second succeeded but sometimes you just want to know if there was an error like in OPEN+GETATTR.

> 
> > +
> > +static void *fuse_compound_parse_one_op(struct fuse_compound_req *compound,
> > +                                       int op_index, void *op_out_data,
> > +                                       void *response_end)
> > +{
> > +       struct fuse_out_header *op_hdr = op_out_data;
> > +       struct fuse_args *args = compound->op_args[op_index];
> 
> op_index is taken straight from "compound->result_header.count" which
> can be any value set by the server. I think we need to either add
> checking for op_index value here or add checking for that in
> fuse_compound_send() before it calls fuse_compound_parse_resp()
> 
> > +
> > +       if (op_hdr->len < sizeof(struct fuse_out_header))
> > +               return NULL;
> > +
> > +       /* Check if the entire operation response fits in the buffer */
> > +       if ((char *)op_out_data + op_hdr->len > (char *)response_end)
> 
> Is there a reason this doesn't just define response_end as a char * in
> fuse_compound_parse_resp() and pass that as a char * to this function?

I can't think of one at the moment.
I rewrote that part multiple times, so there is some inconsistency.

> 
> > +               return NULL;
> > +
> > +       if (op_hdr->error != 0)
> 
> nit: this could just be "if (op_hdr->error)"
> 
> > +               compound->op_errors[op_index] = op_hdr->error;
> 
> If this errors out, is the memcpy still needed? or should this just return NULL?
> 
> > +
> > +       if (args && op_hdr->len > sizeof(struct fuse_out_header))
> 
> imo,  args should be checked right after the "struct fuse_args *args =
> compound->op_args[op_index];" line in the beginning and if it's null,
> t hen fuse_compound_parse_one_op() should return NULL.
> 
> > +               return fuse_copy_response_data(args, op_out_data +
> > +                                              sizeof(struct fuse_out_header));
> > +
> > +       /* No response data, just advance past the header */
> > +       return (char *)op_out_data + op_hdr->len;
> > +}
> > +
> > +static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
> > +                                   u32 count, void *response,
> > +                                   size_t response_size)
> > +{
> > +       void *op_out_data = response;
> 
> imo it's cleaner to just use response instead of defining a new
> op_out_data variable. And if we change the response arg to char *
> response instead of void * response, then that gets rid of a lot of
> the char * casting.
> 
> > +       void *response_end = (char *)response + response_size;
> > +       int i;
> > +
> > +       if (!response || response_size < sizeof(struct fuse_out_header))
> > +               return -EIO;
> > +
> > +       for (i = 0; i < count && i < compound->result_header.count; i++) {
> 
> count is already compound->result_header.count or am I missing something here?
> 
> > +               op_out_data = fuse_compound_parse_one_op(compound, i,
> > +                                                        op_out_data,
> > +                                                        response_end);
> > +               if (!op_out_data)
> > +                       return -EIO;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> > +{
> > +       struct fuse_args args = {
> > +               .opcode = FUSE_COMPOUND,
> > +               .nodeid = 0,
> 
> nit: this line can be removed
> 
> > +               .in_numargs = 2,
> > +               .out_numargs = 2,
> > +               .out_argvar = true,
> > +       };
> > +       size_t resp_buffer_size;
> > +       size_t actual_response_size;
> > +       size_t buffer_pos;
> > +       size_t total_expected_out_size;
> > +       void *buffer = NULL;
> > +       void *resp_payload;
> > +       ssize_t ret;
> > +       int i;
> > +
> > +       if (!compound) {
> > +               pr_info_ratelimited("FUSE: compound request is NULL in %s\n",
> > +                                   __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (compound->compound_header.count == 0) {
> > +               pr_info_ratelimited("FUSE: compound request contains no operations\n");
> > +               return -EINVAL;
> > +       }
> 
> imo we can get rid of these two checks
I actually put them in to see when a fuse server misbehaves but this can easily be removed, we would just lose the information that we probably got a nulled out result.
> 
> > +
> > +       buffer_pos = 0;
> > +       total_expected_out_size = 0;
> 
> Could you move this initialization to the top where the variables get defined?
> 
> > +
> > +       for (i = 0; i < compound->compound_header.count; i++) {
> 
> compound->compound_header.count gets used several times in this
> function. i think it's worth declaring this as a separate (and less
> verbose :)) variable
> 
> > +               struct fuse_args *op_args = compound->op_args[i];
> > +               size_t needed_size = sizeof(struct fuse_in_header);
> > +               int j;
> > +
> > +               for (j = 0; j < op_args->in_numargs; j++)
> > +                       needed_size += op_args->in_args[j].size;
> > +
> > +               buffer_pos += needed_size;
> > +
> > +               for (j = 0; j < op_args->out_numargs; j++)
> > +                       total_expected_out_size += op_args->out_args[j].size;
> > +       }
> > +
> > +       buffer = kvmalloc(buffer_pos, GFP_KERNEL);
> 
> nit: imo it's cleaner to rename resp_buffer_size to buffer_size and
> use that variable for this instead of using buffer_pos
> 
> imo I don't think we need kvmalloc here or below for the resp buffer
> given that compound requests don't support in_pages or out_pages.

yes, this is a victim of my try to do the in/out_pages part as well and then abandoning it for the timebeing.

> 
> > +       if (!buffer)
> > +               return -ENOMEM;
> > +
> > +       buffer_pos = 0;
> > +       for (i = 0; i < compound->compound_header.count; i++) {
> > +               struct fuse_args *op_args = compound->op_args[i];
> > +               struct fuse_in_header *hdr;
> > +               size_t needed_size = sizeof(struct fuse_in_header);
> > +               int j;
> > +
> > +               for (j = 0; j < op_args->in_numargs; j++)
> > +                       needed_size += op_args->in_args[j].size;
> 
> don't we already have the op_args->in_args[] needed size from the
> computation abvoe? could we just reuse that?
> 
> > +
> > +               hdr = (struct fuse_in_header *)(buffer + buffer_pos);
> > +               memset(hdr, 0, sizeof(*hdr));
> > +               hdr->len = needed_size;
> > +               hdr->opcode = op_args->opcode;
> > +               hdr->nodeid = op_args->nodeid;
> > +               hdr->uid = from_kuid(compound->fm->fc->user_ns,
> > +                                    current_fsuid());
> > +               hdr->gid = from_kgid(compound->fm->fc->user_ns,
> > +                                    current_fsgid());
> > +               hdr->pid = pid_nr_ns(task_pid(current),
> > +                                    compound->fm->fc->pid_ns);
> 
> at this point i think it's worth just defining fc at the top of the
> function and using that here
> 
> > +               buffer_pos += sizeof(*hdr);
> > +
> > +               for (j = 0; j < op_args->in_numargs; j++) {
> > +                       memcpy(buffer + buffer_pos, op_args->in_args[j].value,
> > +                              op_args->in_args[j].size);
> > +                       buffer_pos += op_args->in_args[j].size;
> > +               }
> > +       }
> 
> imo this would look nicer as a separate helper function
> 
> > +
> > +       resp_buffer_size = total_expected_out_size +
> > +                          (compound->compound_header.count *
> > +                           sizeof(struct fuse_out_header));
> > +
> > +       resp_payload = kvmalloc(resp_buffer_size, GFP_KERNEL | __GFP_ZERO);
> 
> kvzalloc()?

totally agree

> 
> > +       if (!resp_payload) {
> > +               ret = -ENOMEM;
> > +               goto out_free_buffer;
> > +       }
> > +
> > +       compound->compound_header.result_size = total_expected_out_size;
> > +
> > +       args.in_args[0].size = sizeof(compound->compound_header);
> > +       args.in_args[0].value = &compound->compound_header;
> > +       args.in_args[1].size = buffer_pos;
> > +       args.in_args[1].value = buffer;
> > +
> > +       args.out_args[0].size = sizeof(compound->result_header);
> > +       args.out_args[0].value = &compound->result_header;
> > +       args.out_args[1].size = resp_buffer_size;
> > +       args.out_args[1].value = resp_payload;
> > +
> > +       ret = fuse_simple_request(compound->fm, &args);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       actual_response_size = args.out_args[1].size;
> 
> since out_argvar was set for the FUSE_COMPOUND request args, ret is
> already args.out_args[1].size (see  __fuse_simple_request())

yes, thanks for the hint ...

> 
> > +
> > +       if (actual_response_size < sizeof(struct fuse_compound_out)) {
> 
> can you explain why this checks against size of struct
> fuse_compound_out? afaict from the logic in
> fuse_compound_parse_resp(), actual_response_size doesn't include the
> size of the compound_out struct?

This in hindsight looks like a messed up idea to protect against the first calculations in fuse_compound_parse_resp() but that wouldn't work.
I will recheck that and correct accordingly.

> 
> Thanks,
> Joanne
> 
> 
> > +               pr_info_ratelimited("FUSE: compound response too small (%zu bytes, minimum %zu bytes)\n",
> > +                                   actual_response_size,
> > +                                   sizeof(struct fuse_compound_out));
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> 

Thanks a lot for the review, I appreciate it.

Horst

